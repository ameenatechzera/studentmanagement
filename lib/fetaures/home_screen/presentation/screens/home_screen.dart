import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/fetchschool_parameter.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_status_parameter.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/cubit/feed_cubit.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/main_screen.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/post_card_cristal.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/sidenavigation.dart';
import 'package:studentmanagement/services/notification_service.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(1);
  final ValueNotifier<int> lastPageNotifier = ValueNotifier<int>(1);
  final ValueNotifier<bool> isLoadingMoreNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hasMoreDataNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> isFirstLoadingNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<List<FeedDetails>> allFeedsNotifier =
      ValueNotifier<List<FeedDetails>>([]);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<void>? _refreshCompleter;
  Future<void> saveLoginStatusIfNeeded() async {
    final helper = SharedPreferenceHelper();

    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final lastSavedDate = await helper.getLoginStatusDate();

    if (lastSavedDate != today) {
      context.read<LoginCubit>().saveLoginStatus(
        LoginStatusParameter(admno: AppData.admissionNo!),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    print("🚀 INIT → Fetch page 1");
    getVersion();
    saveLoginStatusIfNeeded();
    print('save loginstatus success');
    _fetchFeeds(page: 1);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService.tryConsumeQueue(); // now navigator definitely exists
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoadingMoreNotifier.value &&
          hasMoreDataNotifier.value) {
        print("🔥 Triggering loadMoreData()");
        loadMoreData();
      }
    });
  }

  Future<void> checkForUpdate(BuildContext context, String appVersion) async {
    final playStoreVersion = await SharedPreferenceHelper()
        .getPlayStoreVersion();

    final appStoreVersion = await SharedPreferenceHelper().getAppStoreVersion();

    print('playStoreVersion: $playStoreVersion');
    print('appStoreVersion: $appStoreVersion');
    print('appVersion: $appVersion');

    String storeVersion = '';

    if (Platform.isAndroid) {
      print('Running on Android');
      storeVersion = playStoreVersion ?? '';
    } else if (Platform.isIOS) {
      print('Running on iOS');
      storeVersion = appStoreVersion ?? '';
    }

    // Fluttertoast.showToast(
    //   msg: "Store Version: $storeVersion",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   backgroundColor: Colors.black87,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );

    if (storeVersion.isNotEmpty && storeVersion.trim() == appVersion.trim()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Available"),
            content: const Text("You have an update. Please update the app."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _fetchFeeds(page: 1);
                },
                child: const Text("Cancel"),
              ),

              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  _fetchFeeds(page: 1);

                  final url = Platform.isAndroid
                      ? 'https://play.google.com/store/apps/details?id=com.techzera.studentmanagement'
                      : 'https://apps.apple.com/app/idYOUR_APP_ID';

                  final Uri uri = Uri.parse(url);

                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                child: const Text("Update"),
              ),
            ],
          );
        },
      );
    } else {
      _fetchFeeds(page: 1);
    }
  }

  Future<void> getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    String st_appVersion = packageInfo.version + "+" + packageInfo.buildNumber;
    print('st_appVersion $st_appVersion');
    // final schoolCode = await SharedPreferenceHelper().getSchoolCode();
    // await context.read<LoginCubit>().fetchSchools(
    //   FetchSchoolRequest(slno: schoolCode),
    // );

    // final playStoreVersion = await SharedPreferenceHelper().getPlayStoreVersion();
    // final appStoreVersion = await SharedPreferenceHelper().getAppStoreVersion();
    // print('playStoreVersionPref $playStoreVersion');
    if (Platform.isAndroid) {
      checkForUpdate(context, st_appVersion!);
    }
  }

  void _fetchFeeds({required int page}) {
    print("🌐 API CALL → page: $page");

    context.read<FeedCubit>().fetchFeeds(
      FetchFeedParameter(
        standardId: AppData.studentStdId!,
        divisionId: AppData.studentDivId!,
        fromDateTime: "",
        admissionNo: AppData.admissionNo!,
        branchId: 1,
        page: page,
        perPage: 12,
      ),
    );
  }

  void loadMoreData() {
    if (isLoadingMoreNotifier.value ||
        !hasMoreDataNotifier.value ||
        currentPageNotifier.value >= lastPageNotifier.value) {
      print(
        "⛔ loadMoreData BLOCKED → isLoadingMore: ${isLoadingMoreNotifier.value} | hasMoreData: ${hasMoreDataNotifier.value} | currentPage: ${currentPageNotifier.value} | lastPage: ${lastPageNotifier.value}",
      );
      return;
    }

    isLoadingMoreNotifier.value = true;
    currentPageNotifier.value = currentPageNotifier.value + 1;

    print("📦 LOAD MORE → next page: ${currentPageNotifier.value}");

    _fetchFeeds(page: currentPageNotifier.value);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    currentPageNotifier.dispose();
    lastPageNotifier.dispose();
    isLoadingMoreNotifier.dispose();
    hasMoreDataNotifier.dispose();
    isFirstLoadingNotifier.dispose();
    allFeedsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getVersion();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: SideNavigationBar(),
      onDrawerChanged: (isOpened) {
        drawerOpenedNotifier.value = isOpened;
      },
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<LoginCubit, LoginState>(
              listener: (context, state) async {
                if (state is LoginStatusSuccess) {
                  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

                  await SharedPreferenceHelper().saveLoginStatusDate(today);

                  print("✅ Login status saved");
                }

                if (state is LoginStatusFailure) {
                  print("❌ ${state.message}");
                }
              },
            ),
          ],
          child: Stack(
            children: [
              BlocConsumer<FeedCubit, FeedState>(
                listener: (context, state) async {
                  if (state is VersionFetchSuccess) {
                    final packageInfo = await PackageInfo.fromPlatform();
                    String st_appVersion =
                        packageInfo.version + "+" + packageInfo.buildNumber;
                    print('st_appVersion $st_appVersion');
                    // final schoolCode =
                    // await SharedPreferenceHelper().getSchoolCode();
                    // await context.read<LoginCubit>().fetchSchools(
                    //   FetchSchoolRequest(slno: schoolCode),
                    // );
                    if (Platform.isAndroid) {
                      await checkForUpdate(context, st_appVersion);
                    }
                  }

                  if (state is FeedLoaded) {
                    final newFeeds = state.response.data ?? [];
                    final pagination = state.response.pagination;

                    isFirstLoadingNotifier.value = false;
                    isLoadingMoreNotifier.value = false;

                    lastPageNotifier.value = pagination?.lastPage ?? 1;
                    hasMoreDataNotifier.value =
                        currentPageNotifier.value < lastPageNotifier.value;

                    if (currentPageNotifier.value == 1) {
                      allFeedsNotifier.value = List<FeedDetails>.from(newFeeds);
                    } else {
                      allFeedsNotifier.value = [
                        ...allFeedsNotifier.value,
                        ...newFeeds,
                      ];
                    }
                    if (_refreshCompleter != null &&
                        !_refreshCompleter!.isCompleted) {
                      _refreshCompleter!.complete();
                    }
                    final ids = allFeedsNotifier.value
                        .map((e) => e.feedId)
                        .toList();
                    final uniqueIds = ids.toSet();
                    if (ids.length != uniqueIds.length) {
                      // duplicate detected
                    }
                    final schoolCode = await SharedPreferenceHelper()
                        .getSchoolCode();
                    await context.read<LoginCubit>().fetchSchools(
                      FetchSchoolRequest(slno: schoolCode),
                    );
                  }

                  if (state is FeedError) {
                    isFirstLoadingNotifier.value = false;
                    isLoadingMoreNotifier.value = false;

                    if (currentPageNotifier.value > 1) {
                      currentPageNotifier.value = currentPageNotifier.value - 1;
                    }
                    if (_refreshCompleter != null &&
                        !_refreshCompleter!.isCompleted) {
                      _refreshCompleter!.complete();
                    }
                  }
                },
                builder: (context, state) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: isFirstLoadingNotifier,
                    builder: (context, isFirstLoading, _) {
                      return ValueListenableBuilder<List<FeedDetails>>(
                        valueListenable: allFeedsNotifier,
                        builder: (context, allFeeds, __) {
                          if (isFirstLoading && state is FeedLoading) {
                            return PostCardSkeleton();
                          }

                          if (state is FeedError && allFeeds.isEmpty) {
                            return Center(child: Text(state.message));
                          }

                          if (allFeeds.isEmpty) {
                            return const Center(
                              child: Text("No feeds available"),
                            );
                          }

                          return ValueListenableBuilder<bool>(
                            valueListenable: isLoadingMoreNotifier,
                            builder: (context, isLoadingMore, ___) {
                              return ValueListenableBuilder<bool>(
                                valueListenable: hasMoreDataNotifier,
                                builder: (context, hasMoreData, ____) {
                                  return RefreshIndicator(
                                    color: Colors.deepPurple,
                                    onRefresh: () async {
                                      currentPageNotifier.value = 1;
                                      lastPageNotifier.value = 1;
                                      hasMoreDataNotifier.value = true;
                                      isLoadingMoreNotifier.value = false;

                                      //allFeedsNotifier.value = [];
                                      _refreshCompleter = Completer<void>();
                                      _fetchFeeds(page: 1);
                                      return _refreshCompleter!.future;
                                      // // Wait until loading finishes
                                      // while (isFirstLoadingNotifier.value) {
                                      //   await Future.delayed(
                                      //     const Duration(milliseconds: 100),
                                      //   );
                                      // }
                                    },
                                    child: CustomScrollView(
                                      physics: BouncingScrollPhysics(),
                                      controller: _scrollController,
                                      slivers: [
                                        SliverList(
                                          delegate: SliverChildBuilderDelegate((
                                            context,
                                            index,
                                          ) {
                                            if (index == allFeeds.length) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 20,
                                                    ),
                                                child: Center(
                                                  child: isLoadingMore
                                                      ? const CircularProgressIndicator()
                                                      : const SizedBox(),
                                                ),
                                              );
                                            }

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                              ),
                                              child: PostCard(
                                                feed: allFeeds[index],
                                              ),
                                            );
                                          }, childCount: allFeeds.length + 1),
                                        ),

                                        /// Extra space for bottom bar
                                        const SliverToBoxAdapter(
                                          child: SizedBox(height: 100),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),

              // ✅ FIXED: Drawer toggle button with HitTestBehavior.opaque
              Positioned(
                left: 0,
                top: MediaQuery.of(context).size.height * 0.4,
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  behavior: HitTestBehavior
                      .opaque, // ✅ Key fix — transparent areas now receive taps
                  child: Container(
                    width: 24,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(20),
                      ),
                    ),
                    child: const Icon(Icons.chevron_right, size: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:studentmanagement/core/appdata/appdata.dart';
// import 'package:studentmanagement/core/database/app_database.dart';
// import 'package:studentmanagement/fetaures/home_screen/data/local/dao/feed_dao.dart';
// import 'package:studentmanagement/fetaures/home_screen/data/repositories/feed_local_repository.dart';
// import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';
// import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
// import 'package:studentmanagement/fetaures/home_screen/presentation/cubit/feed_cubit.dart';
// import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/post_card_cristal.dart';
// import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/sidenavigation.dart';
// import 'package:studentmanagement/services/service_locator.dart';
// import 'package:studentmanagement/services/shared_preference_helper.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ScrollController _scrollController = ScrollController();

//   final ValueNotifier<List<FeedDetails>> allFeedsNotifier =
//       ValueNotifier<List<FeedDetails>>([]);

//   final ValueNotifier<bool> isFirstLoadingNotifier = ValueNotifier<bool>(true);

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     print("🧠 DAO HASH: ${sl<FeedDao>().hashCode}");
//     print("🧠 DB HASH: ${sl<AppDatabase>().hashCode}");
//     print("🚀 INIT → Loading LOCAL FEEDS ONLY");

//     getVersion();

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await Future.delayed(const Duration(milliseconds: 300));
//       await loadFeedsFromLocal();
//     });

//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//           _scrollController.position.maxScrollExtent - 200) {
//         print("📜 Scroll reached bottom (LOCAL ONLY)");
//       }
//     });
//   }

//   // @override
//   // void initState() {
//   //   super.initState();

//   //   print("🚀 INIT → Loading LOCAL FEEDS ONLY");

//   //   getVersion();

//   //   WidgetsBinding.instance.addPostFrameCallback((_) async {
//   //     await Future.delayed(const Duration(milliseconds: 300));
//   //     await loadFeedsFromLocal();
//   //   });
//   // }

//   /// ✅ LOAD FROM FLOOR DB ONLY
//   Future<void> loadFeedsFromLocal() async {
//     print("📥 START LOCAL LOAD");
//     try {
//       print("📥 Fetching feeds from LOCAL DB...");

//       final repo = FeedLocalRepository(sl<FeedDao>());

//       final localFeeds = await repo.getFeeds();

//       print("📦 Local feeds count: ${localFeeds.length}");

//       for (var f in localFeeds) {
//         print("➡️ Feed: ${f.feedId} | ${f.feedText}");
//       }

//       allFeedsNotifier.value = localFeeds;
//       isFirstLoadingNotifier.value = false;
//     } catch (e) {
//       print("❌ Error loading local feeds: $e");
//       isFirstLoadingNotifier.value = false;
//     }
//   }

//   Future<void> checkForUpdate(BuildContext context, String appVersion) async {
//     final playStoreVersion = await SharedPreferenceHelper()
//         .getPlayStoreVersion();

//     final appStoreVersion = await SharedPreferenceHelper().getAppStoreVersion();

//     String storeVersion = '';

//     if (Platform.isAndroid) {
//       storeVersion = playStoreVersion ?? '';
//     } else if (Platform.isIOS) {
//       storeVersion = appStoreVersion ?? '';
//     }

//     // Fluttertoast.showToast(
//     //   msg: "Store Version: $storeVersion",
//     //   toastLength: Toast.LENGTH_SHORT,
//     //   gravity: ToastGravity.BOTTOM,
//     //   backgroundColor: Colors.black87,
//     //   textColor: Colors.white,
//     //   fontSize: 16.0,
//     // );

//     if (storeVersion.isNotEmpty && storeVersion.trim() == appVersion.trim()) {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text("Update Available"),
//             content: const Text("Please update the app."),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("Cancel"),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.pop(context);

//                   final url = Platform.isAndroid
//                       ? 'https://play.google.com/store/apps/details?id=com.techzera.studentmanagement'
//                       : 'https://apps.apple.com/app/idYOUR_APP_ID';

//                   final Uri uri = Uri.parse(url);

//                   if (await canLaunchUrl(uri)) {
//                     await launchUrl(uri, mode: LaunchMode.externalApplication);
//                   }
//                 },
//                 child: const Text("Update"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//     // else {
//     //   _fetchFeeds(page: 1);
//     // }
//   }

//   Future<void> getVersion() async {
//     final packageInfo = await PackageInfo.fromPlatform();

//     String version = "${packageInfo.version}+${packageInfo.buildNumber}";

//     print('📦 App Version: $version');

//     checkForUpdate(context, version);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     allFeedsNotifier.dispose();
//     isFirstLoadingNotifier.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("🏠 HOME SCREEN BUILD");
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.white,
//       drawer: SideNavigationBar(),
//       body: SafeArea(
//         child: BlocListener<FeedCubit, FeedState>(
//           listener: (context, state) async {
//             print("🔥 STATE => ${state.runtimeType}");

//             if (state is FeedLoadedFromLocal) {
//               print("✅ RELOADING LOCAL DATA");
//               await loadFeedsFromLocal();
//             }

//             if (state is FeedError) {
//               print("❌ API ERROR => ${state.message}");
//             }
//           },
//           child: Stack(
//             children: [
//               /// ✅ LOCAL FEED UI ONLY
//               ValueListenableBuilder<List<FeedDetails>>(
//                 valueListenable: allFeedsNotifier,
//                 builder: (context, allFeeds, _) {
//                   return ValueListenableBuilder<bool>(
//                     valueListenable: isFirstLoadingNotifier,
//                     builder: (context, isLoading, __) {
//                       // if (isLoading) {
//                       //   return const Center(child: CircularProgressIndicator());
//                       // }
//                       if (isLoading) {
//                         return const PostCardSkeleton();
//                       }

//                       if (allFeeds.isEmpty) {
//                         return const Center(
//                           child: Text("No feeds available (Local DB)"),
//                         );
//                       }

//                       return RefreshIndicator(
//                         onRefresh: _refreshFeeds,
//                         child: CustomScrollView(
//                           physics: const AlwaysScrollableScrollPhysics(
//                             parent: BouncingScrollPhysics(),
//                           ),
//                           controller: _scrollController,
//                           slivers: [
//                             SliverList(
//                               delegate: SliverChildBuilderDelegate((
//                                 context,
//                                 index,
//                               ) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(top: 8.0),
//                                   child: PostCard(feed: allFeeds[index]),
//                                 );
//                               }, childCount: allFeeds.length),
//                             ),

//                             /// Extra space for bottom bar
//                             const SliverToBoxAdapter(
//                               child: SizedBox(height: 100),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),

//               /// Drawer button
//               Positioned(
//                 left: 0,
//                 top: MediaQuery.of(context).size.height * 0.4,
//                 child: GestureDetector(
//                   onTap: () {
//                     _scaffoldKey.currentState?.openDrawer();
//                   },
//                   behavior: HitTestBehavior
//                       .opaque, // ✅ Key fix — transparent areas now receive taps
//                   child: Container(
//                     width: 24,
//                     height: 80,
//                     decoration: const BoxDecoration(
//                       color: Colors.black12,
//                       borderRadius: BorderRadius.horizontal(
//                         right: Radius.circular(20),
//                       ),
//                     ),
//                     child: const Icon(Icons.chevron_right, size: 18),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _fetchFeeds({required int page}) async {
//     print("🌐 API CALL → page: $page");

//     print("1️⃣ BEFORE read");

//     final cubit = context.read<FeedCubit>();

//     print("2️⃣ AFTER read");

//     await cubit.refreshFeeds(
//       FetchFeedParameter(
//         standardId: AppData.studentStdId!,
//         divisionId: AppData.studentDivId!,
//         fromDateTime: "",
//         admissionNo: AppData.admissionNo!,
//         branchId: 1,
//         page: page,
//         perPage: 12,
//       ),
//     );

//     print("3️⃣ AFTER fetchFeeds");
//   }
//   // Future<void> _fetchFeeds({required int page}) async {
//   //   print("🌐 API CALL → page: $page");

//   //   await context.read<FeedCubit>().fetchFeeds(
//   //     FetchFeedParameter(
//   //       standardId: AppData.studentStdId!,
//   //       divisionId: AppData.studentDivId!,
//   //       fromDateTime: "",
//   //       admissionNo: AppData.admissionNo!,
//   //       branchId: 1,
//   //       page: page,
//   //       perPage: 12,
//   //     ),
//   //   );
//   // }

//   Future<void> _refreshFeeds() async {
//     print("🔄 REFRESH TRIGGERED");
//     await _fetchFeeds(page: 1);

//     // await Future.delayed(const Duration(seconds: 1));
//     print("🔄 API CALL FINISHED");
//     //await loadFeedsFromLocal();
//   }

//   // Future<void> _refreshFeeds() async {
//   //   await _fetchFeeds(page: 1); // fetch latest from server
//   //   await loadFeedsFromLocal(); // reload UI from Floor
//   // }
// }
