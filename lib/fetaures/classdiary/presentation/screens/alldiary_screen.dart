import 'package:flutter/material.dart';

final ValueNotifier<String> selectedSubject = ValueNotifier<String>(
  'Mathematics',
);

final ValueNotifier<int?> expandedIndexNotifier = ValueNotifier<int?>(null);

class AllClassDiaryScreen extends StatelessWidget {
  const AllClassDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                              _radioItem(context, 'Mathematics', value),
                              _radioItem(context, 'Malayalam', value),
                              _radioItem(context, 'Physics', value),
                              _radioItem(context, 'Chemistry', value),
                              _radioItem(context, 'Biology', value),
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
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 20,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
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
                        expandedIndexNotifier.value = isExpanded ? null : index;
                      },
                      title: Text(
                        '${selectedSubject.value} - Chapter ${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'This is the diary entry for chapter ${index + 1}.',
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            if (!isExpanded) Text('04-02-2026'),
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
                          'This is the detailed diary entry for chapter ${index + 1}. Here you can add notes, homework, or any additional info.',
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Widget _radioItem(BuildContext context, String text, String groupValue) {
  return RadioListTile<String>(
    value: text,
    groupValue: groupValue,
    dense: true,
    title: Text(text),
    activeColor: const Color(0xFFC4005F),
    contentPadding: EdgeInsets.zero,
    onChanged: (val) {
      selectedSubject.value = val!;
      Navigator.pop(context);
    },
  );
}
