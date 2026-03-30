
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

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  print('AccYear ${AppData.accYear!}');
    /// 🔹 Call API
    context.read<FeedCubit>().fetchFeeds(
      FetchFeedParameter(
        accYear: AppData.accYear!,
        standardId: AppData.studentStdId!,
        divisionId: AppData.studentDivId!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<FeedCubit>().fetchFeeds(
      FetchFeedParameter(
        accYear: AppData.accYear!,
        standardId: AppData.studentStdId!,
        divisionId: AppData.studentDivId!,
      ),
    );
    return Scaffold(
      drawer: SideNavigationBar(),
      appBar: AppBar(title: const Text("Home")),
      body: SafeArea(
        child: Column(
          children: [
            const HeaderSection(),
            const SizedBox(height: 10),

            /// 🔹 Feed List
            Expanded(
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

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: feeds.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            PostCard(feed: feeds[index]),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
