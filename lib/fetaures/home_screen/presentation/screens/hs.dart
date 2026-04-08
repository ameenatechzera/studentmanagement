// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:studentmanagement/core/appdata/appdata.dart';
// import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
// import 'package:studentmanagement/fetaures/home_screen/presentation/cubit/feed_cubit.dart';
// import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/post_card_cristal.dart';
// import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/header_cristal.dart';
// import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/sidenavigation.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// final ScrollController _scrollController = ScrollController();

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     print('AccYear ${AppData.accYear!}');

//     /// 🔹 Call API
//     context.read<FeedCubit>().fetchFeeds(
//       FetchFeedParameter(
//         standardId: AppData.studentStdId!,
//         divisionId: AppData.studentDivId!,
//         fromDateTime: "",
//         page: 1,
//         perPage: 10,
//       ),
//     );
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//           _scrollController.position.maxScrollExtent - 200) {
//         loadMoreData(); // 👈 call API or add data
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.black,
//       drawer: SideNavigationBar(),
//       appBar: AppBar(
//         title: const Text("Home"),
//       ), //, backgroundColor: Colors.black),
//       body: SafeArea(
//         child: BlocBuilder<FeedCubit, FeedState>(
//           builder: (context, state) {
//             if (state is FeedLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state is FeedError) {
//               return Center(child: Text(state.message));
//             }

//             if (state is FeedLoaded) {
//               final feeds = state.response.data ?? [];

//               if (feeds.isEmpty) {
//                 return const Center(child: Text("No feeds available"));
//               }

//               return CustomScrollView(
//                 controller: _scrollController,
//                 //padding: const EdgeInsets.symmetric(horizontal: 16),
//                 slivers: [
//                   /// 🔹 HEADER
//                   const SliverToBoxAdapter(child: HeaderSection()),

//                   /// 🔹 API FEEDS
//                   SliverList(
//                     delegate: SliverChildBuilderDelegate((context, index) {
//                       return Column(
//                         children: [
//                           const SizedBox(height: 16),
//                           PostCard(feed: feeds[index]),
//                           const SizedBox(height: 16),
//                         ],
//                       );
//                     }, childCount: feeds.length),
//                   ),
//                 ],
//               );
//             }

//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }

//   void loadMoreData() {
//     context.read<FeedCubit>().fetchFeeds(
//       FetchFeedParameter(
//         // accYear: AppData.accYear!,
//         standardId: AppData.studentStdId!,
//         divisionId: AppData.studentDivId!,
//         fromDateTime: "",
//         page: 1,
//         perPage: 10,
//       ),
//     );
//   }
// }
