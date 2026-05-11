import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:studentmanagement/fetaures/marklist/presentation/cubit/marklist_cubit.dart';

import 'marklistDetails_screen.dart';

class MarkListPage extends StatefulWidget {
  const MarkListPage({super.key});

  @override
  State<MarkListPage> createState() => _MarkListPageState();
}

class _MarkListPageState extends State<MarkListPage> {
  final TextEditingController searchController = TextEditingController();

  List<dynamic> allExamTerms = [];
  List<dynamic> filteredExamTerms = [];

  @override
  void initState() {
    super.initState();
    context.read<MarklistCubit>().fetchExamTerms();
  }

  void filterList(String query) {
    final filtered = allExamTerms.where((item) {
      final name = (item.examTermName ?? "").toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredExamTerms = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text("Mark List", style: TextStyle(color: Colors.black)),
      ),
      body: BlocBuilder<MarklistCubit, MarklistState>(
        builder: (context, state) {
          if (state is ExamTermsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ExamTermsError) {
            return Center(child: Text(state.message));
          }

          if (state is ExamTermsLoaded) {
            allExamTerms = state.response.data ?? [];

            // initialize filtered list only once
            if (searchController.text.isEmpty) {
              filteredExamTerms = allExamTerms;
            }

            if (allExamTerms.isEmpty) {
              return const Center(child: Text("No Exam Terms Found"));
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// 🔍 Search Box
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: filterList,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// ❗ No Results
                  if (filteredExamTerms.isEmpty)
                    const Expanded(
                      child: Center(child: Text("No results found")),
                    )
                  else
                    /// 📋 List
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: filteredExamTerms.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = filteredExamTerms[index];

                          return MarkCard(
                            title: item.examTermName ?? "No Name",
                            date: item.examTermId?.toString() ?? "N/A",
                            color: index % 3 == 0
                                ? Colors.blue
                                : index % 3 == 1
                                ? Colors.green
                                : Colors.orange,
                            termId: item.examTermId?.toString() ?? "0",
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

/// 📦 Card Widget
class MarkCard extends StatelessWidget {
  final String title;
  final String date;
  final String termId;
  final Color color;

  const MarkCard({
    super.key,
    required this.title,
    required this.date,
    required this.color,
    required this.termId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await AppNavigator.pushSlide(
          context: context,
          page: ExamMarkDetailsPage(examTermId: termId, examTerm: title),
        );
        // 🔥 Reload after coming back
        context.read<MarklistCubit>().fetchExamTerms();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Left Color Bar
            Container(
              width: 4,
              height: 80,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// Icon
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.description, color: Colors.blue),
            ),

            const SizedBox(width: 12),

            /// Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(date, style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
