import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/core/config/colors.dart';
import 'package:studentmanagement/fetaures/marklist/domain/parameter/fetch_marklist_parameter.dart';
import 'package:studentmanagement/fetaures/marklist/presentation/cubit/marklist_cubit.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

class ExamMarkDetailsPage extends StatefulWidget {
  final String examTermId;
  final String examTerm;
  const ExamMarkDetailsPage({
    super.key,
    required this.examTermId,
    required this.examTerm,
  });

  @override
  State<ExamMarkDetailsPage> createState() => _ExamMarkDetailsPageState();

}
String classAndDivision ='';

class _ExamMarkDetailsPageState extends State<ExamMarkDetailsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      String? value = await SharedPreferenceHelper().getClassAndDivision();
      setState(() {
        classAndDivision = value ?? "";
      });

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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 👈 we control pop manually
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, true); // 🔥 send result back
          context.read<MarklistCubit>().fetchExamTerms();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF3F3F7),
        body: Column(
          children: [
            /// 🔵 Top Section
            Container(
              padding: const EdgeInsets.only(
                top: 50,
                left: 1,
                right: 16,
                bottom: 20,
              ),
              color: appBlueTheme,
              child: Column(
                children: [
                  /// AppBar Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<MarklistCubit>().fetchExamTerms();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.examTerm + " Mark List",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Download",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.download, color: Colors.white, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// 👤 Profile Card
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: cardColor,
                      ),
                      child: Stack(
                        children: [
                          /// 🖼️ Image on right-middle
                          Positioned(
                            right: -10,
                            top: 10,
                            bottom: 10,
                            child: Opacity(
                              opacity: 0.99, // 👈 adjust visibility
                              child: Image.asset(
                                "assets/images/mask_bg.png",
                                color: Colors.white,
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          /// 🔲 Black background
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              // color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 24,
                                      backgroundImage: NetworkImage(
                                        "https://i.pravatar.cc/150?img=3",
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "" + AppData.studentName!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                /// Info Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InfoItem(
                                      title: "Class",
                                      value: (classAndDivision)
                                    ),
                                    InfoItem(
                                      title: "Admission No",
                                      value: AppData.admissionNo!,
                                    ),
                                    InfoItem(
                                      title: "Academic Year",
                                      value: AppData.accYear!,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// 📊 Table Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              color: const Color(0xffE6E6F2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subject",
                    style: TextStyle(
                      color: appBlueFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Mark Obtained",
                    style: TextStyle(
                      color: appBlueFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Total Mark",
                    style: TextStyle(
                      color: appBlueFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Grade",
                    style: TextStyle(
                      color: appBlueFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            BlocBuilder<MarklistCubit, MarklistState>(
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

                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero, // 🔥 IMPORTANT
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final isEven = index % 2 == 0;

                        return Container(
                          color: isEven
                              ? Colors.white
                              : const Color(0xffECEAFF), // 👈 second color
                          child: MarkRow(
                            "${index + 1} " + data[index].subjectName!,
                            data[index].te!,
                            data[index].ce!,
                            data[index].grade!,
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 📌 Info Widget
class InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const InfoItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// 📌 Row Item
class MarkRow extends StatelessWidget {
  final String subject;
  final String mark;
  final String total;
  final String grade;

  const MarkRow(this.subject, this.mark, this.total, this.grade, {super.key});

  Color getGradeColor() {
    if (grade == "D") return Colors.red;
    if (grade == "A1") return Colors.green;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text("${subject}", style: TextStyle(fontSize: 13)),
          ),

          Expanded(flex: 1, child: Text(total, style: TextStyle(fontSize: 13))),

          Expanded(
            flex: 1,
            child: Center(
              child: Text("${mark}", style: TextStyle(fontSize: 13)),
            ),
          ),

          Expanded(
            flex: 1,
            child: Center(
              child: Text((grade).toString(), style: TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}
