import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:studentmanagement/fetaures/marklist/presentation/cubit/marklist_cubit.dart';
import 'package:studentmanagement/fetaures/marklist/presentation/screens/marklist_expansion_screen.dart';

class MarkListScreen extends StatelessWidget {
  const MarkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MarklistCubit>().fetchExamTerms();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: Text('MarkList')),
      body: BlocBuilder<MarklistCubit, MarklistState>(
        builder: (context, state) {
          if (state is ExamTermsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ❌ Error
          if (state is ExamTermsError) {
            return Center(child: Text(state.message));
          }
          if (state is ExamTermsLoaded) {
            final examTerms = state.response.data ?? [];

            if (examTerms.isEmpty) {
              return const Center(child: Text("No Exam Terms Found"));
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                final item = examTerms[index];

                return Container(
                  height: 80,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,

                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.green.shade100,
                      child: Icon(Icons.description, color: Colors.black),
                    ),

                    title: Text(
                      item.examTermName ?? "No Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    trailing: CircleAvatar(
                      radius: 12,
                      backgroundColor: const Color(0xFFC4005F),
                      child: Icon(
                        Icons.download,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),

                    onTap: () {
                      AppNavigator.pushSlide(
                        context: context,
                        page: MarklistExpansionScreen(
                          examTermId: item.examTermId!,
                        ),
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: examTerms.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
