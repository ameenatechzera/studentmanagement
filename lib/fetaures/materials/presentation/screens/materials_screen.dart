import 'package:flutter/material.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:studentmanagement/fetaures/materials/presentation/screens/notes_expansion_screen.dart';

final ValueNotifier<String> selectedSubject = ValueNotifier<String>(
  'Mathematics',
);

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Materials Name'),
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
                        width: 220, // 👈 slightly bigger
                        child: ValueListenableBuilder<String>(
                          valueListenable: selectedSubject,
                          builder: (_, value, _) {
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

          // 🔹 TAB BAR (ONLY TABS HERE)
          bottom: const TabBar(
            indicatorColor: Color(0xFFC4005F),
            labelColor: Color(0xFFC4005F),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'PDF'),
              Tab(text: 'Link'),
              Tab(text: 'Notes'),
            ],
          ),
        ),

        // 🔹 TAB VIEWS (LISTS HERE)
        body: TabBarView(
          children: [
            // PDF LIST
            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) {
                final ValueNotifier<bool> isFav = ValueNotifier<bool>(false);

                return Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
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
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/icons/Group (1).png'),
                    ),
                    title: Text('chapter 1:Number Systems'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: isFav,
                          builder: (_, value, __) {
                            return IconButton(
                              onPressed: () => isFav.value = !value,
                              icon: Icon(
                                Icons.star,
                                color: value ? Colors.yellow : Colors.grey,
                              ),
                            );
                          },
                        ),
                        // SizedBox(width: 10),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: const Color(0xffffc4005f),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.download,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // LINK LIST
            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) {
                final ValueNotifier<bool> isFav = ValueNotifier<bool>(false);
                return Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ListTile(
                      title: Text('chapter 1:Number Systems'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: isFav,
                            builder: (_, value, _) {
                              return IconButton(
                                onPressed: () => isFav.value = !value,
                                icon: Icon(
                                  Icons.star,
                                  color: value ? Colors.yellow : Colors.grey,
                                ),
                              );
                            },
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: const Color(0xffffc4005f),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // NOTES LIST
            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) {
                final ValueNotifier<bool> isFav = ValueNotifier<bool>(false);
                return Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ListTile(
                      onTap: () {
                        AppNavigator.pushSlide(
                          context: context,
                          page: NotesExpansionScreen(),
                        );

                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return NotesExpansionScreen();
                        //     },
                        //   ),
                        // );
                      },
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFADDFFF),
                        ),
                        child: const Icon(Icons.note, color: Colors.black),
                      ),
                      title: Text('chapter 1:Number Systems'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: isFav,
                            builder: (_, value, _) {
                              return IconButton(
                                onPressed: () => isFav.value = !value,
                                icon: Icon(
                                  Icons.star,
                                  color: value ? Colors.yellow : Colors.grey,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
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
