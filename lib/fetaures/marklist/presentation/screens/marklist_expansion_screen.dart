import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/marklist/domain/parameter/fetch_marklist_parameter.dart';
import 'package:studentmanagement/fetaures/marklist/presentation/cubit/marklist_cubit.dart';

class MarklistExpansionScreen extends StatefulWidget {
  final String examTermId;

  const MarklistExpansionScreen({super.key, required this.examTermId});

  @override
  State<MarklistExpansionScreen> createState() =>
      _MarklistExpansionScreenState();
}

class _MarklistExpansionScreenState extends State<MarklistExpansionScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<MarklistCubit>().fetchMarkList(
        FetchMarkListParameter(
          branchId: 1,
          accYear: AppData.accYear!,
          standardId: AppData.studentStdId!.toString(),
          divisionId: AppData.studentDivId!.toString(),
          examTermId: widget.examTermId,
          admno: AppData.admissionNo!.toString(),
        ),
      );
    });
  }

  void _reloadExamTerms() {
    context.read<MarklistCubit>().fetchExamTerms();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          _reloadExamTerms();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Mark List")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<MarklistCubit, MarklistState>(
            builder: (context, state) {
              if (state is MarkListLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is MarkListError) {
                return Center(child: Text(state.message));
              }

              if (state is MarkListLoaded) {
                final data = state.response.data ?? [];

                if (data.isEmpty) {
                  return const Center(child: Text("No Data Found"));
                }

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Expanded(flex: 1, child: Text("Sl")),
                          SizedBox(width: 10),
                          Expanded(flex: 4, child: Text("Subject")),
                          Expanded(flex: 3, child: Text("Mark Obtained")),
                          Expanded(flex: 2, child: Text("Total Mark")),
                        ],
                      ),
                    ),

                    /// 🔹 LIST
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          final isEven = index.isEven;

                          return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: isEven ? 20 : 12,
                              horizontal: 12,
                            ),
                            color: isEven ? Colors.white : Colors.pink.shade50,
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Text("${index + 1}")),

                                Expanded(
                                  flex: 3,
                                  child: Text(item.subjectName ?? "-"),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      "${item.te ?? 0} + ${item.ce ?? 0}",
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      ((int.tryParse(item.te ?? "0") ?? 0) +
                                              (int.tryParse(item.ce ?? "0") ??
                                                  0))
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC4005F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.download, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Download',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
