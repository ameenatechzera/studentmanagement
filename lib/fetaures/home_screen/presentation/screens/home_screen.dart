import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/cubit/feed_cubit.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/header_cristal.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/post_card_cristal.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/sidenavigation.dart';

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

  @override
  void initState() {
    super.initState();

    print("🚀 INIT → Fetch page 1");
    _fetchFeeds(page: 1);

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

  void _fetchFeeds({required int page}) {
    print("🌐 API CALL → page: $page");

    context.read<FeedCubit>().fetchFeeds(
      FetchFeedParameter(
        standardId: AppData.studentStdId!,
        divisionId: AppData.studentDivId!,
        fromDateTime: "",
        page: page,
        perPage: 3,
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
    return Scaffold(
      drawer: SideNavigationBar(),
      appBar: AppBar(title: const Text("Home")),
      body: SafeArea(
        child: BlocConsumer<FeedCubit, FeedState>(
          listener: (context, state) {
            if (state is FeedLoaded) {
              final newFeeds = state.response.data ?? [];
              final pagination = state.response.pagination;

              print("✅ API SUCCESS → page: ${currentPageNotifier.value}");
              print("📊 New items count: ${newFeeds.length}");
              print(
                "🆕 New Feed IDs: ${newFeeds.map((e) => e.feedId).toList()}",
              );

              isFirstLoadingNotifier.value = false;
              isLoadingMoreNotifier.value = false;

              lastPageNotifier.value = pagination?.lastPage ?? 1;
              hasMoreDataNotifier.value =
                  currentPageNotifier.value < lastPageNotifier.value;

              if (currentPageNotifier.value == 1) {
                allFeedsNotifier.value = List<FeedDetails>.from(newFeeds);
                print("🧹 RESET LIST (page 1)");
              } else {
                allFeedsNotifier.value = [
                  ...allFeedsNotifier.value,
                  ...newFeeds,
                ];
                print("➕ APPENDED DATA");
              }

              print(
                "📦 ALL Feed IDs: ${allFeedsNotifier.value.map((e) => e.feedId).toList()}",
              );

              final ids = allFeedsNotifier.value.map((e) => e.feedId).toList();
              final uniqueIds = ids.toSet();

              if (ids.length != uniqueIds.length) {
                print("❌ DUPLICATE DETECTED!");
              } else {
                print("✅ NO DUPLICATES");
              }

              print(
                "📄 PAGINATION → currentPage: ${currentPageNotifier.value} | lastPage: ${lastPageNotifier.value} | hasMoreData: ${hasMoreDataNotifier.value}",
              );
              print(
                "📌 FINAL STATE → totalItems: ${allFeedsNotifier.value.length}",
              );
            }

            if (state is FeedError) {
              print("❌ API ERROR: ${state.message}");

              isFirstLoadingNotifier.value = false;
              isLoadingMoreNotifier.value = false;

              if (currentPageNotifier.value > 1) {
                currentPageNotifier.value = currentPageNotifier.value - 1;
                print("↩️ PAGE ROLLBACK → ${currentPageNotifier.value}");
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
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is FeedError && allFeeds.isEmpty) {
                      return Center(child: Text(state.message));
                    }

                    if (allFeeds.isEmpty) {
                      return const Center(child: Text("No feeds available"));
                    }

                    return ValueListenableBuilder<bool>(
                      valueListenable: isLoadingMoreNotifier,
                      builder: (context, isLoadingMore, ___) {
                        return ValueListenableBuilder<bool>(
                          valueListenable: hasMoreDataNotifier,
                          builder: (context, hasMoreData, ____) {
                            return CustomScrollView(
                              controller: _scrollController,
                              slivers: [
                                const SliverToBoxAdapter(
                                  child: HeaderSection(),
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate((
                                    context,
                                    index,
                                  ) {
                                    if (index == allFeeds.length) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                        ),
                                        child: Center(
                                          child: isLoadingMore
                                              ? const CircularProgressIndicator()
                                              : !hasMoreData
                                              ? const Text("No more feeds")
                                              : const SizedBox(),
                                        ),
                                      );
                                    }

                                    return Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        PostCard(feed: allFeeds[index]),
                                        const SizedBox(height: 16),
                                      ],
                                    );
                                  }, childCount: allFeeds.length + 1),
                                ),
                              ],
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
      ),
    );
  }
}
