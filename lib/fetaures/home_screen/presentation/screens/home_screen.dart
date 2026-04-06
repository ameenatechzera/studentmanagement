import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/cubit/feed_cubit.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/post_card_cristal.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/header_cristal.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/sidenavigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final ScrollController _scrollController = ScrollController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    print('AccYear ${AppData.accYear!}');

    /// 🔹 Call API
    context.read<FeedCubit>().fetchFeeds(
      FetchFeedParameter(
        standardId: AppData.studentStdId!,
        divisionId: AppData.studentDivId!,
      ),
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        loadMoreData(); // 👈 call API or add data
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      drawer: SideNavigationBar(),
      appBar: AppBar(
        title: const Text("Home"),
      ), //, backgroundColor: Colors.black),
      body: SafeArea(
        child: BlocBuilder<FeedCubit, FeedState>(
          builder: (context, state) {
            if (state is FeedLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is FeedError) {
              return Center(child: Text(state.message));
            }

            if (state is FeedLoaded) {
              final feeds = state.response.data ?? [];

              if (feeds.isEmpty) {
                return const Center(child: Text("No feeds available"));
              }

              return CustomScrollView(
                controller: _scrollController,
                //padding: const EdgeInsets.symmetric(horizontal: 16),
                slivers: [
                  /// 🔹 HEADER
                  const SliverToBoxAdapter(child: HeaderSection()),

                  /// 🔹 API FEEDS
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Column(
                        children: [
                          const SizedBox(height: 16),
                          PostCard(feed: feeds[index]),
                          const SizedBox(height: 16),
                        ],
                      );
                    }, childCount: feeds.length),
                  ),

                  // /// 🔥 HARD CODED DUMMY POSTS (NO MODEL)
                  // SliverToBoxAdapter(
                  //   child: Column(
                  //     children: List.generate(5, (index) {
                  //       return Column(
                  //         children: [
                  //           Container(
                  //             color: Colors.white,
                  //             child: Column(
                  //               crossAxisAlignment:
                  //                   CrossAxisAlignment.start,
                  //               children: [
                  //                 /// top row
                  //                 const ListTile(
                  //                   leading: CircleAvatar(
                  //                     backgroundImage: AssetImage(
                  //                       'assets/images/fsp_logo.png',
                  //                     ),
                  //                   ),
                  //                   title: Text("Dummy FSP"),
                  //                   subtitle: Text("Just now"),
                  //                 ),

                  //                 /// image
                  //                 Image.network(
                  //                   "https://picsum.photos/500/300?random=$index",
                  //                   width: double.infinity,
                  //                   height: 200,
                  //                   fit: BoxFit.cover,
                  //                 ),

                  //                 /// text
                  //                 const Padding(
                  //                   padding: EdgeInsets.all(12),
                  //                   child: Text(
                  //                     "This is dummy post for scrolling testing",
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           const SizedBox(height: 16),
                  //         ],
                  //       );
                  //     }),
                  //   ),
                  // ),

                  // const SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  void loadMoreData() {
    context.read<FeedCubit>().fetchFeeds(
      FetchFeedParameter(
        // accYear: AppData.accYear!,
        standardId: AppData.studentStdId!,
        divisionId: AppData.studentDivId!,
      ),
    );
  }
}
