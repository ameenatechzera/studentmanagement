import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/fetch_diary_parameter.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/cubit/diary_cubit.dart';
import 'package:studentmanagement/fetaures/materials/presentation/widgets/materials_widget.dart';

final ValueNotifier<String> selectedSubject = ValueNotifier<String>(
  'Mathematics',
);

final ValueNotifier<int?> expandedIndexNotifier = ValueNotifier<int?>(null);

class AllClassDiaryScreen extends StatelessWidget {
  const AllClassDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DiaryCubit>().fetchDiary(
        FetchDiaryParameter(admNo: AppData.admissionNo!, accYear: AppData.accYear!),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Class Diary'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 208, 205, 205),
                borderRadius: BorderRadius.circular(30),
              ),
              child: PopupMenuButton(
                icon: const Icon(Icons.filter_list),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: false,
                    child: SizedBox(
                      width: 220,
                      child: ValueListenableBuilder<String>(
                        valueListenable: selectedSubject,
                        builder: (_, value, __) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              radioItem(context, 'Mathematics', value),
                              radioItem(context, 'Malayalam', value),
                              radioItem(context, 'Physics', value),
                              radioItem(context, 'Chemistry', value),
                              radioItem(context, 'Biology', value),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<DiaryCubit, DiaryState>(
        builder: (context, state) {
          if (state is DiaryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DiaryError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is DiaryLoaded) {
            final diaryList = state.response.data ?? [];

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: diaryList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final diary = diaryList[index];
                String desc = diary.description ?? '';
                String st_diaryHead = desc.length > 8 ? desc.substring(0, 8) : desc;
                st_diaryHead = st_diaryHead+'...';
                return ValueListenableBuilder<int?>(
                  valueListenable: expandedIndexNotifier,
                  builder: (_, expandedIndex, __) {
                    final isExpanded = expandedIndex == index;

                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F9),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            onTap: () {
                              expandedIndexNotifier.value = isExpanded
                                  ? null
                                  : index;
                            },
                            title: Text(
                              diary.diaryTitle ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(st_diaryHead),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                children: [
                             Text(diary.diaryDate!),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      expandedIndexNotifier.value = isExpanded
                                          ? null
                                          : index;
                                    },
                                    child: Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_down
                                          : Icons.arrow_forward_ios,
                                      size: 18,
                                      color: const Color(0xFFC4005F),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (isExpanded)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 16,
                                right: 16,
                              ),
                              child: Text(
                                diary.description!,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
