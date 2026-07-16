// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:studentmanagement/core/appdata/appdata.dart';
// // import 'package:studentmanagement/core/config/colors.dart';
// // import 'package:studentmanagement/fetaures/marklist/domain/parameter/fetch_marklist_parameter.dart';
// // import 'package:studentmanagement/fetaures/marklist/presentation/cubit/marklist_cubit.dart';
// // import 'package:studentmanagement/services/shared_preference_helper.dart';

// // class ExamMarkDetailsPage extends StatefulWidget {
// //   final String examTermId;
// //   final String examTerm;
// //   const ExamMarkDetailsPage({
// //     super.key,
// //     required this.examTermId,
// //     required this.examTerm,
// //   });

// //   @override
// //   State<ExamMarkDetailsPage> createState() => _ExamMarkDetailsPageState();
// // }

// // String classAndDivision = '';

// // class _ExamMarkDetailsPageState extends State<ExamMarkDetailsPage> {
// //   @override
// //   void initState() {
// //     super.initState();

// //     Future.microtask(() async {
// //       String? value = await SharedPreferenceHelper().getClassAndDivision();
// //       setState(() {
// //         classAndDivision = value ?? "";
// //       });

// //       context.read<MarklistCubit>().fetchMarkList(
// //         FetchMarkListParameter(
// //           branchId: 1,
// //           accYear: AppData.accYear!,
// //           standardId: AppData.studentStdId!.toString(),
// //           divisionId: AppData.studentDivId!.toString(),
// //           examTermId: widget.examTermId,
// //           admno: AppData.admissionNo!.toString(),
// //         ),
// //       );
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return PopScope(
// //       canPop: false, // 👈 we control pop manually
// //       onPopInvokedWithResult: (didPop, result) {
// //         if (!didPop) {
// //           Navigator.pop(context, true); // 🔥 send result back
// //           context.read<MarklistCubit>().fetchExamTerms();
// //         }
// //       },
// //       child: Scaffold(
// //         backgroundColor: const Color(0xffF3F3F7),
// //         body: Column(
// //           children: [
// //             /// 🔵 Top Section
// //             Container(
// //               padding: const EdgeInsets.only(
// //                 top: 50,
// //                 left: 1,
// //                 right: 16,
// //                 bottom: 20,
// //               ),
// //               color: appBlueTheme,
// //               child: Column(
// //                 children: [
// //                   /// AppBar Row
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Row(
// //                         children: [
// //                           IconButton(
// //                             onPressed: () {
// //                               Navigator.pop(context);
// //                               context.read<MarklistCubit>().fetchExamTerms();
// //                             },
// //                             icon: const Icon(
// //                               Icons.arrow_back,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                           Text(
// //                             widget.examTerm + " Mark List",
// //                             style: const TextStyle(
// //                               color: Colors.white,
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ),
// //                         ],
// //                       ),

// //                       Container(
// //                         padding: const EdgeInsets.symmetric(
// //                           horizontal: 10,
// //                           vertical: 6,
// //                         ),
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(20),
// //                           border: Border.all(color: Colors.white),
// //                         ),
// //                         child: const Row(
// //                           children: [
// //                             Text(
// //                               "Download",
// //                               style: TextStyle(color: Colors.white),
// //                             ),
// //                             SizedBox(width: 4),
// //                             Icon(Icons.download, color: Colors.white, size: 16),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),

// //                   const SizedBox(height: 20),

// //                   /// 👤 Profile Card
// //                   Padding(
// //                     padding: const EdgeInsets.only(left: 16.0),
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(10),
// //                         color: cardColor,
// //                       ),
// //                       child: Stack(
// //                         children: [
// //                           /// 🖼️ Image on right-middle
// //                           Positioned(
// //                             right: -10,
// //                             top: 10,
// //                             bottom: 10,
// //                             child: Opacity(
// //                               opacity: 0.99, // 👈 adjust visibility
// //                               child: Image.asset(
// //                                 "assets/images/mask_bg.png",
// //                                 color: Colors.white,
// //                                 height: 100,
// //                                 fit: BoxFit.contain,
// //                               ),
// //                             ),
// //                           ),

// //                           /// 🔲 Black background
// //                           Container(
// //                             padding: const EdgeInsets.all(16),
// //                             decoration: BoxDecoration(
// //                               // color: Colors.black.withOpacity(0.1),
// //                               borderRadius: BorderRadius.circular(10),
// //                             ),
// //                             child: Column(
// //                               children: [
// //                                 Row(
// //                                   children: [
// //                                     CircleAvatar(
// //                                       radius: 25,
// //                                       backgroundImage:
// //                                           (AppData.profileUrl != null &&
// //                                               AppData.profileUrl!.isNotEmpty)
// //                                           ? NetworkImage(AppData.profileUrl!)
// //                                           : null,
// //                                       child:
// //                                           (AppData.profileUrl == null ||
// //                                               AppData.profileUrl!.isEmpty)
// //                                           ? ClipOval(
// //                                               child: Image.asset(
// //                                                 getGenderImage(),
// //                                                 fit: BoxFit.cover,
// //                                                 width: 50,
// //                                                 height: 50,
// //                                               ),
// //                                             )
// //                                           : null,
// //                                     ),
// //                                     const SizedBox(width: 12),
// //                                     Text(
// //                                       "" + AppData.studentName!,
// //                                       style: const TextStyle(
// //                                         color: Colors.white,
// //                                         fontSize: 16,
// //                                         fontWeight: FontWeight.w600,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 const SizedBox(height: 16),

// //                                 /// Info Row
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     InfoItem(
// //                                       title: "Class",
// //                                       value: (classAndDivision),
// //                                     ),
// //                                     InfoItem(
// //                                       title: "Admission No",
// //                                       value: AppData.admissionNo!,
// //                                     ),
// //                                     InfoItem(
// //                                       title: "Academic Year",
// //                                       value: AppData.accYear!,
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             /// 📊 Table Header
// //             Container(
// //               padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
// //               color: const Color(0xffE6E6F2),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text(
// //                     "Subject",
// //                     style: TextStyle(
// //                       color: appBlueFont,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 11,
// //                     ),
// //                   ),
// //                   Text(
// //                     "Mark Obtained",
// //                     style: TextStyle(
// //                       color: appBlueFont,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 11,
// //                     ),
// //                   ),
// //                   Text(
// //                     "Total Mark",
// //                     style: TextStyle(
// //                       color: appBlueFont,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 11,
// //                     ),
// //                   ),
// //                   Text(
// //                     "Grade",
// //                     style: TextStyle(
// //                       color: appBlueFont,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 11,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             BlocBuilder<MarklistCubit, MarklistState>(
// //               builder: (context, state) {
// //                 if (state is MarkListLoading) {
// //                   return const Center(child: CircularProgressIndicator());
// //                 }

// //                 if (state is MarkListError) {
// //                   return Center(child: Text(state.message));
// //                 }
// //                 if (state is MarkListLoaded) {
// //                   final data = state.response.data ?? [];

// //                   if (data.isEmpty) {
// //                     return const Center(child: Text("No Data Found"));
// //                   }

// //                   return Expanded(
// //                     child: ListView.builder(
// //                       padding: EdgeInsets.zero, // 🔥 IMPORTANT
// //                       itemCount: data.length,
// //                       itemBuilder: (context, index) {
// //                         final isEven = index % 2 == 0;

// //                         return Container(
// //                           color: isEven
// //                               ? Colors.white
// //                               : const Color(0xffECEAFF), // 👈 second color
// //                           child: MarkRow(
// //                             "${index + 1} " + data[index].subjectName!,
// //                             data[index].te!,
// //                             data[index].ce!,
// //                             data[index].grade!,
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   );
// //                 }
// //                 return const SizedBox();
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // /// 📌 Info Widget
// // class InfoItem extends StatelessWidget {
// //   final String title;
// //   final String value;

// //   const InfoItem({super.key, required this.title, required this.value});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Text(title, style: const TextStyle(color: Colors.white)),
// //         const SizedBox(height: 4),
// //         Text(
// //           value,
// //           style: const TextStyle(
// //             color: Colors.white,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // /// 📌 Row Item
// // class MarkRow extends StatelessWidget {
// //   final String subject;
// //   final String mark;
// //   final String total;
// //   final String grade;

// //   const MarkRow(this.subject, this.mark, this.total, this.grade, {super.key});

// //   Color getGradeColor() {
// //     if (grade == "D") return Colors.red;
// //     if (grade == "A1") return Colors.green;
// //     return Colors.black;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
// //       decoration: BoxDecoration(
// //         border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
// //       ),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             flex: 2,
// //             child: Text("${subject}", style: TextStyle(fontSize: 13)),
// //           ),

// //           Expanded(flex: 1, child: Text(total, style: TextStyle(fontSize: 13))),

// //           Expanded(
// //             flex: 1,
// //             child: Center(
// //               child: Text("${mark}", style: TextStyle(fontSize: 13)),
// //             ),
// //           ),

// //           Expanded(
// //             flex: 1,
// //             child: Center(
// //               child: Text((grade).toString(), style: TextStyle(fontSize: 13)),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // String getGenderImage() {
// //   final g = (AppData.gender ?? '').toLowerCase().trim();

// //   if (g == 'male') {
// //     return "assets/icons/c0d90970-7626-47b6-a097-ca0834c7a05f_removalai_preview.png";
// //   } else if (g == 'female') {
// //     return "assets/icons/1f5debb8-6e36-4d25-bde8-526f4dd89820_removalai_preview.png";
// //   } else {
// //     return "assets/images/defaultstudent.png";
// //   }
// // }

// // import 'dart:io';
// // import 'dart:typed_data';
// // import 'dart:ui' as ui;

// // import 'package:flutter/material.dart';
// // import 'package:flutter/rendering.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:studentmanagement/core/appdata/appdata.dart';
// // import 'package:studentmanagement/fetaures/marklist/domain/parameter/fetch_marklist_parameter.dart';
// // import 'package:studentmanagement/fetaures/marklist/presentation/cubit/marklist_cubit.dart';
// // import 'package:studentmanagement/services/shared_preference_helper.dart';

// // class ExamMarkDetailsPage extends StatefulWidget {
// //   final String examTermId;
// //   final String examTerm;

// //   const ExamMarkDetailsPage({
// //     super.key,
// //     required this.examTermId,
// //     required this.examTerm,
// //   });

// //   @override
// //   State<ExamMarkDetailsPage> createState() => _ExamMarkDetailsPageState();
// // }

// // class _ExamMarkDetailsPageState extends State<ExamMarkDetailsPage> {
// //   final TransformationController _zoomController = TransformationController();
// //   final GlobalKey _reportKey = GlobalKey();

// //   String classAndDivision = '';

// //   @override
// //   void initState() {
// //     super.initState();

// //     Future.microtask(() async {
// //       final String? value = await SharedPreferenceHelper()
// //           .getClassAndDivision();

// //       if (!mounted) return;

// //       setState(() {
// //         classAndDivision = value ?? '';
// //       });

// //       context.read<MarklistCubit>().fetchMarkList(
// //         FetchMarkListParameter(
// //           branchId: 1,
// //           accYear: AppData.accYear!,
// //           standardId: AppData.studentStdId!.toString(),
// //           divisionId: AppData.studentDivId!.toString(),
// //           examTermId: widget.examTermId,
// //           admno: AppData.admissionNo!.toString(),
// //         ),
// //       );
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _zoomController.dispose();
// //     super.dispose();
// //   }

// //   void _goBack() {
// //     Navigator.pop(context, true);
// //     context.read<MarklistCubit>().fetchExamTerms();
// //   }

// //   Future<void> _downloadReportAsImage() async {
// //     try {
// //       final BuildContext? reportContext = _reportKey.currentContext;

// //       if (reportContext == null) {
// //         _showMessage('Report is not ready yet');
// //         return;
// //       }

// //       final RenderObject? renderObject = reportContext.findRenderObject();

// //       if (renderObject == null || renderObject is! RenderRepaintBoundary) {
// //         _showMessage('Unable to capture report');
// //         return;
// //       }

// //       final ui.Image image = await renderObject.toImage(pixelRatio: 3);
// //       final ByteData? byteData = await image.toByteData(
// //         format: ui.ImageByteFormat.png,
// //       );

// //       if (byteData == null) {
// //         _showMessage('Unable to generate image');
// //         return;
// //       }

// //       final Uint8List pngBytes = byteData.buffer.asUint8List();

// //       final Directory directory = await getApplicationDocumentsDirectory();

// //       final String safeExamTerm = widget.examTerm
// //           .trim()
// //           .replaceAll(RegExp(r'[^A-Za-z0-9_ -]'), '')
// //           .replaceAll(' ', '_');

// //       final String fileName =
// //           'progress_report_${safeExamTerm}_${DateTime.now().millisecondsSinceEpoch}.png';

// //       final File file = File('${directory.path}/$fileName');

// //       await file.writeAsBytes(pngBytes);

// //       if (!mounted) return;

// //       _showMessage('Report downloaded successfully');
// //     } catch (e) {
// //       _showMessage('Download failed');
// //     }
// //   }

// //   void _showMessage(String message) {
// //     if (!mounted) return;

// //     ScaffoldMessenger.of(context)
// //       ..clearSnackBars()
// //       ..showSnackBar(
// //         SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
// //       );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return PopScope(
// //       canPop: false,
// //       onPopInvokedWithResult: (didPop, result) {
// //         if (!didPop) _goBack();
// //       },
// //       child: Scaffold(
// //         backgroundColor: Colors.white,
// //         appBar: AppBar(
// //           backgroundColor: Colors.white,
// //           elevation: 0,
// //           leading: IconButton(
// //             onPressed: _goBack,
// //             icon: const Icon(Icons.arrow_back, color: Colors.black),
// //           ),
// //           title: Text(
// //             '${widget.examTerm} Progress Report',
// //             maxLines: 1,
// //             overflow: TextOverflow.ellipsis,
// //             style: const TextStyle(
// //               color: Colors.black,
// //               fontSize: 16,
// //               fontWeight: FontWeight.w700,
// //             ),
// //           ),
// //           actions: [
// //             IconButton(
// //               onPressed: _downloadReportAsImage,
// //               icon: const Icon(Icons.download_rounded, color: Colors.black),
// //             ),
// //           ],
// //         ),
// //         body: BlocBuilder<MarklistCubit, MarklistState>(
// //           builder: (context, state) {
// //             if (state is MarkListLoading) {
// //               return const Center(child: CircularProgressIndicator());
// //             }

// //             if (state is MarkListError) {
// //               return Center(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(20),
// //                   child: Text(
// //                     state.message,
// //                     textAlign: TextAlign.center,
// //                     style: const TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 14,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             }

// //             if (state is MarkListLoaded) {
// //               final data = state.response.data ?? [];

// //               if (data.isEmpty) {
// //                 return const Center(
// //                   child: Text(
// //                     'No Data Found',
// //                     style: TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 14,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                 );
// //               }

// //               return _buildZoomableMobileScreen(data);
// //             }

// //             return const SizedBox();
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildZoomableMobileScreen(List<dynamic> data) {
// //     return GestureDetector(
// //       onDoubleTap: () {
// //         _zoomController.value = Matrix4.identity();
// //       },
// //       child: InteractiveViewer(
// //         transformationController: _zoomController,
// //         minScale: 1,
// //         maxScale: 3.5,
// //         panEnabled: true,
// //         scaleEnabled: true,
// //         boundaryMargin: const EdgeInsets.all(60),
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.fromLTRB(12, 14, 12, 24),
// //           child: RepaintBoundary(
// //             key: _reportKey,
// //             child: _buildReportMobileUi(data),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildReportMobileUi(List<dynamic> data) {
// //     final List<_ScholasticRow> rows = _buildScholasticRows(data);

// //     final double totalMaxMark = rows.fold<double>(
// //       0,
// //       (sum, row) => sum + row.maxMark,
// //     );

// //     final double totalMarkScored = rows.fold<double>(
// //       0,
// //       (sum, row) => sum + row.markScored,
// //     );

// //     final double totalOutOf25 = rows.fold<double>(
// //       0,
// //       (sum, row) => sum + row.marksOutOf25,
// //     );

// //     final double percentage = totalMaxMark > 0
// //         ? (totalMarkScored / totalMaxMark) * 100
// //         : 0.0;

// //     final String overallGrade = _gradeFromPercentage(percentage);

// //     return Container(
// //       color: Colors.white,
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.stretch,
// //         children: [
// //           _buildSchoolHeader(),
// //           const SizedBox(height: 16),
// //           Text(
// //             'PROGRESS REPORT ${_safe(AppData.accYear, '2025-2026')}',
// //             textAlign: TextAlign.center,
// //             style: const TextStyle(
// //               fontSize: 17,
// //               fontWeight: FontWeight.w900,
// //               color: Colors.black,
// //             ),
// //           ),
// //           const SizedBox(height: 10),
// //           Center(
// //             child: Container(
// //               width: 210,
// //               height: 34,
// //               alignment: Alignment.center,
// //               decoration: BoxDecoration(
// //                 border: Border.all(color: Colors.red, width: 1.5),
// //               ),
// //               child: Text(
// //                 widget.examTerm.toUpperCase(),
// //                 style: const TextStyle(
// //                   fontSize: 13,
// //                   fontWeight: FontWeight.w900,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 18),
// //           _buildStudentDetails(),
// //           const SizedBox(height: 14),
// //           _sectionTitle('SCHOLASTIC AREA'),
// //           _buildScholasticTable(rows),
// //           const SizedBox(height: 10),
// //           _buildOverallSummary(
// //             overallMarks: totalOutOf25,
// //             percentage: percentage,
// //             grade: overallGrade,
// //           ),
// //           const SizedBox(height: 16),
// //           _buildActivitySection(
// //             title: 'Co-Scholastic Activities',
// //             rows: const [
// //               _ActivityRow('Extra Curricular Activity', 'A'),
// //               _ActivityRow('Home Work & Co-operations', 'B'),
// //               _ActivityRow('Neatness & Tidiness', 'A'),
// //             ],
// //           ),
// //           const SizedBox(height: 12),
// //           _buildActivitySection(
// //             title: 'Discipline',
// //             rows: const [_ActivityRow('Discipline & Moral Values', 'A')],
// //           ),
// //           const SizedBox(height: 90),
// //           _buildSignatureRow(),
// //           const SizedBox(height: 12),
// //           _buildBottomNotes(),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSchoolHeader() {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         _logoBox(),
// //         const SizedBox(width: 8),
// //         Expanded(
// //           child: Column(
// //             children: [
// //               Text(
// //                 _safe(
// //                   AppData.branchName,
// //                   'EZHIMALA ENGLISH SCHOOL',
// //                 ).toUpperCase(),
// //                 textAlign: TextAlign.center,
// //                 style: const TextStyle(
// //                   fontSize: 15,
// //                   fontWeight: FontWeight.w900,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //               const SizedBox(height: 6),
// //               const Text(
// //                 'Affiliated to CBSE New Delhi Reg.No: 930114',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontSize: 8,
// //                   fontWeight: FontWeight.w800,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //               const SizedBox(height: 4),
// //               const Text(
// //                 'KAKKAMPARA - Ettikulam, P.O PALAKODE - 670305, KANNUR Dist',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontSize: 7.2,
// //                   fontWeight: FontWeight.w800,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //               const SizedBox(height: 4),
// //               const Text(
// //                 'Phone: 04985 210285 / 04985 298610, Email: ezhimala.in',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontSize: 7.2,
// //                   fontWeight: FontWeight.w800,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         const SizedBox(width: 8),
// //         _logoBox(),
// //       ],
// //     );
// //   }

// //   Widget _logoBox() {
// //     return Container(
// //       width: 54,
// //       height: 54,
// //       alignment: Alignment.center,
// //       decoration: BoxDecoration(
// //         shape: BoxShape.circle,
// //         border: Border.all(color: Colors.black, width: 1),
// //       ),
// //       child: const Text(
// //         'LOGO',
// //         style: TextStyle(
// //           fontSize: 7,
// //           fontWeight: FontWeight.w900,
// //           color: Colors.black,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildStudentDetails() {
// //     return Column(
// //       children: [
// //         Row(
// //           children: [
// //             Expanded(
// //               child: _detailLine(
// //                 "Student's Name",
// //                 _safe(AppData.studentName, ''),
// //               ),
// //             ),
// //             const SizedBox(width: 8),
// //             Expanded(
// //               child: _detailLine(
// //                 'Adm No',
// //                 _safe(AppData.admissionNo, ''),
// //                 valueBold: true,
// //               ),
// //             ),
// //           ],
// //         ),
// //         Row(
// //           children: [
// //             Expanded(child: _detailLine("Father's Name", '-')),
// //             const SizedBox(width: 8),
// //             Expanded(child: _detailLine('Class', classAndDivision)),
// //           ],
// //         ),
// //         Row(
// //           children: [
// //             Expanded(child: _detailLine("Mother's Name", '-')),
// //             const SizedBox(width: 8),
// //             Expanded(child: _detailLine('DOB', '-')),
// //           ],
// //         ),
// //         Row(
// //           children: [
// //             Expanded(child: _detailLine('Address', '-')),
// //             const SizedBox(width: 8),
// //             Expanded(child: _detailLine('Mobile No', '-')),
// //           ],
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _detailLine(String label, String value, {bool valueBold = false}) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 6),
// //       child: Row(
// //         children: [
// //           SizedBox(
// //             width: 74,
// //             child: Text(
// //               label,
// //               style: const TextStyle(
// //                 fontSize: 7.4,
// //                 fontWeight: FontWeight.w800,
// //                 color: Colors.black,
// //               ),
// //             ),
// //           ),
// //           const Text(
// //             ':',
// //             style: TextStyle(
// //               fontSize: 7.4,
// //               fontWeight: FontWeight.w900,
// //               color: Colors.black,
// //             ),
// //           ),
// //           const SizedBox(width: 5),
// //           Expanded(
// //             child: Text(
// //               value,
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis,
// //               style: TextStyle(
// //                 fontSize: valueBold ? 15 : 7.8,
// //                 fontWeight: valueBold ? FontWeight.w900 : FontWeight.w800,
// //                 color: Colors.black,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _sectionTitle(String title) {
// //     return Container(
// //       height: 24,
// //       alignment: Alignment.center,
// //       decoration: BoxDecoration(
// //         border: Border.all(color: Colors.black, width: 1),
// //       ),
// //       child: Text(
// //         title,
// //         style: const TextStyle(
// //           fontSize: 9,
// //           fontWeight: FontWeight.w900,
// //           color: Colors.black,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildScholasticTable(List<_ScholasticRow> rows) {
// //     final double totalMaxMark = rows.fold<double>(
// //       0,
// //       (sum, row) => sum + row.maxMark,
// //     );

// //     final double totalMarkScored = rows.fold<double>(
// //       0,
// //       (sum, row) => sum + row.markScored,
// //     );

// //     final double totalOutOf25 = rows.fold<double>(
// //       0,
// //       (sum, row) => sum + row.marksOutOf25,
// //     );

// //     final double totalPercentage = totalMaxMark > 0
// //         ? (totalMarkScored / totalMaxMark) * 100
// //         : 0.0;

// //     final String totalGrade = _gradeFromPercentage(totalPercentage);

// //     return Table(
// //       border: TableBorder.all(color: Colors.black, width: 0.8),
// //       columnWidths: const {
// //         0: FlexColumnWidth(2.45),
// //         1: FlexColumnWidth(0.8),
// //         2: FlexColumnWidth(0.9),
// //         3: FlexColumnWidth(1.12),
// //         4: FlexColumnWidth(0.9),
// //         5: FlexColumnWidth(0.65),
// //       },
// //       children: [
// //         TableRow(
// //           children: [
// //             _tableHeader('Subject Name'),
// //             _tableHeader('Max. Mark'),
// //             _tableHeader('Mark Scored'),
// //             _tableHeader('Marks Out of 25'),
// //             _tableHeader('Percentage'),
// //             _tableHeader('Grade'),
// //           ],
// //         ),
// //         ...rows.map((row) {
// //           return TableRow(
// //             children: [
// //               _tableCell(row.subject, align: TextAlign.left, bold: true),
// //               _tableCell(_formatNumber(row.maxMark)),
// //               _tableCell(_formatNumber(row.markScored)),
// //               _tableCell(_formatNumber(row.marksOutOf25)),
// //               _tableCell(_formatNumber(row.percentage)),
// //               _tableCell(row.grade, bold: true),
// //             ],
// //           );
// //         }),
// //         TableRow(
// //           children: [
// //             _tableCell('Total', align: TextAlign.left, bold: true),
// //             _tableCell(_formatNumber(totalMaxMark), bold: true),
// //             _tableCell(_formatNumber(totalMarkScored), bold: true),
// //             _tableCell(_formatNumber(totalOutOf25), bold: true),
// //             _tableCell(_formatNumber(totalPercentage), bold: true),
// //             _tableCell(totalGrade, bold: true),
// //           ],
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _tableHeader(String text) {
// //     return Container(
// //       height: 24,
// //       alignment: Alignment.center,
// //       padding: const EdgeInsets.symmetric(horizontal: 2),
// //       child: Text(
// //         text,
// //         textAlign: TextAlign.center,
// //         style: const TextStyle(
// //           fontSize: 6.4,
// //           fontWeight: FontWeight.w900,
// //           color: Colors.black,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _tableCell(
// //     String text, {
// //     TextAlign align = TextAlign.center,
// //     bool bold = false,
// //   }) {
// //     return Container(
// //       height: 24,
// //       alignment: align == TextAlign.left
// //           ? Alignment.centerLeft
// //           : Alignment.center,
// //       padding: const EdgeInsets.symmetric(horizontal: 3),
// //       child: Text(
// //         text,
// //         textAlign: align,
// //         maxLines: 1,
// //         overflow: TextOverflow.ellipsis,
// //         style: TextStyle(
// //           fontSize: 6.7,
// //           fontWeight: bold ? FontWeight.w900 : FontWeight.w700,
// //           color: Colors.black,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildOverallSummary({
// //     required double overallMarks,
// //     required double percentage,
// //     required String grade,
// //   }) {
// //     return Wrap(
// //       spacing: 6,
// //       runSpacing: 6,
// //       crossAxisAlignment: WrapCrossAlignment.center,
// //       children: [
// //         _summaryLabel('Overall Marks'),
// //         _summaryValue('${_formatNumber(overallMarks)} / 100', width: 82),
// //         _summaryLabel('Percentage'),
// //         _summaryValue(_formatNumber(percentage), width: 58),
// //         _summaryLabel('Attendance'),
// //         _summaryValue('-', width: 58),
// //         _summaryLabel('Overall Grade'),
// //         _summaryValue(grade, width: 52),
// //       ],
// //     );
// //   }

// //   Widget _summaryLabel(String text) {
// //     return Text(
// //       text,
// //       style: const TextStyle(
// //         fontSize: 7,
// //         fontWeight: FontWeight.w900,
// //         color: Colors.black,
// //       ),
// //     );
// //   }

// //   Widget _summaryValue(String text, {required double width}) {
// //     return Container(
// //       width: width,
// //       height: 22,
// //       alignment: Alignment.center,
// //       decoration: BoxDecoration(
// //         border: Border.all(color: Colors.black, width: 1),
// //       ),
// //       child: Text(
// //         text,
// //         style: const TextStyle(
// //           fontSize: 7,
// //           fontWeight: FontWeight.w900,
// //           color: Colors.black,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildActivitySection({
// //     required String title,
// //     required List<_ActivityRow> rows,
// //   }) {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
// //       decoration: BoxDecoration(
// //         border: Border.all(color: Colors.black, width: 1),
// //       ),
// //       child: Column(
// //         children: [
// //           Text(
// //             title,
// //             style: const TextStyle(
// //               fontSize: 8,
// //               fontWeight: FontWeight.w900,
// //               color: Colors.black,
// //             ),
// //           ),
// //           const SizedBox(height: 8),
// //           Row(
// //             children: [
// //               Expanded(
// //                 flex: 58,
// //                 child: Table(
// //                   border: TableBorder.all(color: Colors.black, width: 0.8),
// //                   children: [
// //                     TableRow(children: [_smallHeader('Activities')]),
// //                     ...rows.map((row) {
// //                       return TableRow(
// //                         children: [
// //                           _smallCell(row.activity, align: TextAlign.left),
// //                         ],
// //                       );
// //                     }),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(width: 20),
// //               Expanded(
// //                 flex: 36,
// //                 child: Table(
// //                   border: TableBorder.all(color: Colors.black, width: 0.8),
// //                   children: [
// //                     TableRow(
// //                       children: [_smallHeader(widget.examTerm.toUpperCase())],
// //                     ),
// //                     TableRow(children: [_smallHeader('Grade')]),
// //                     ...rows.map((row) {
// //                       return TableRow(children: [_smallCell(row.grade)]);
// //                     }),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _smallHeader(String text) {
// //     return Container(
// //       height: 21,
// //       alignment: Alignment.center,
// //       padding: const EdgeInsets.symmetric(horizontal: 4),
// //       child: Text(
// //         text,
// //         textAlign: TextAlign.center,
// //         style: const TextStyle(
// //           fontSize: 6.8,
// //           fontWeight: FontWeight.w900,
// //           color: Colors.black,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _smallCell(String text, {TextAlign align = TextAlign.center}) {
// //     return Container(
// //       height: 21,
// //       alignment: align == TextAlign.left
// //           ? Alignment.centerLeft
// //           : Alignment.center,
// //       padding: const EdgeInsets.symmetric(horizontal: 5),
// //       child: Text(
// //         text,
// //         textAlign: align,
// //         style: const TextStyle(
// //           fontSize: 6.8,
// //           fontWeight: FontWeight.w700,
// //           color: Colors.black,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildSignatureRow() {
// //     return const Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(
// //           "Class Teacher's Sign",
// //           style: TextStyle(
// //             fontSize: 7,
// //             fontWeight: FontWeight.w800,
// //             color: Colors.black,
// //           ),
// //         ),
// //         Text(
// //           "Principal's Sign",
// //           style: TextStyle(
// //             fontSize: 7,
// //             fontWeight: FontWeight.w800,
// //             color: Colors.black,
// //           ),
// //         ),
// //         Text(
// //           "Parent's Sign",
// //           style: TextStyle(
// //             fontSize: 7,
// //             fontWeight: FontWeight.w800,
// //             color: Colors.black,
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildBottomNotes() {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.only(top: 8),
// //       decoration: const BoxDecoration(
// //         border: Border(top: BorderSide(color: Colors.black, width: 1)),
// //       ),
// //       child: const Column(
// //         children: [
// //           Text(
// //             'Activities Grade : A = Outstanding, B = Very Good, C = Good, D = Need Improvement',
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               fontSize: 6,
// //               fontWeight: FontWeight.w900,
// //               color: Colors.black,
// //             ),
// //           ),
// //           SizedBox(height: 7),
// //           Text(
// //             'Mark Vs. Grade : A1=90-100, A2=80-89, B1=70-79, B2=60-69, C1=50-59, C2=40-49, D=33-39',
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               fontSize: 6,
// //               fontWeight: FontWeight.w900,
// //               color: Colors.black,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   List<_ScholasticRow> _buildScholasticRows(List<dynamic> data) {
// //     return List<_ScholasticRow>.generate(data.length, (index) {
// //       final dynamic item = data[index];

// //       final String subjectName = _safe(
// //         item.subjectName,
// //         'Subject ${index + 1}',
// //       );

// //       final double maxMark = _toDouble(item.ce, fallback: 50);
// //       final double markScored = _toDouble(item.te, fallback: 0);

// //       final double marksOutOf25 = maxMark > 0
// //           ? (markScored / maxMark) * 25
// //           : 0.0;

// //       final double percentage = maxMark > 0
// //           ? (markScored / maxMark) * 100
// //           : 0.0;

// //       final String grade = _safe(item.grade, _gradeFromPercentage(percentage));

// //       return _ScholasticRow(
// //         subject: subjectName,
// //         maxMark: maxMark,
// //         markScored: markScored,
// //         marksOutOf25: marksOutOf25,
// //         percentage: percentage,
// //         grade: grade,
// //       );
// //     });
// //   }

// //   double _toDouble(dynamic value, {double fallback = 0}) {
// //     if (value == null) return fallback;

// //     final String text = value.toString().trim();

// //     if (text.isEmpty || text.toLowerCase() == 'null') {
// //       return fallback;
// //     }

// //     return double.tryParse(text) ?? fallback;
// //   }

// //   String _safe(dynamic value, [String fallback = '-']) {
// //     final String text = value?.toString().trim() ?? '';

// //     if (text.isEmpty || text.toLowerCase() == 'null') {
// //       return fallback;
// //     }

// //     return text;
// //   }

// //   String _formatNumber(double value) {
// //     if (value % 1 == 0) {
// //       return value.toInt().toString();
// //     }

// //     return value.toStringAsFixed(2);
// //   }

// //   String _gradeFromPercentage(double percentage) {
// //     if (percentage >= 90) return 'A1';
// //     if (percentage >= 80) return 'A2';
// //     if (percentage >= 70) return 'B1';
// //     if (percentage >= 60) return 'B2';
// //     if (percentage >= 50) return 'C1';
// //     if (percentage >= 40) return 'C2';
// //     if (percentage >= 33) return 'D';
// //     return 'E';
// //   }
// // }

// // class _ScholasticRow {
// //   final String subject;
// //   final double maxMark;
// //   final double markScored;
// //   final double marksOutOf25;
// //   final double percentage;
// //   final String grade;

// //   const _ScholasticRow({
// //     required this.subject,
// //     required this.maxMark,
// //     required this.markScored,
// //     required this.marksOutOf25,
// //     required this.percentage,
// //     required this.grade,
// //   });
// // }

// // class _ActivityRow {
// //   final String activity;
// //   final String grade;

// //   const _ActivityRow(this.activity, this.grade);
// // }
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:studentmanagement/core/appdata/appdata.dart';
// import 'package:studentmanagement/fetaures/authentication/domain/entities/getbranch_entitiy.dart';
// import 'package:studentmanagement/fetaures/marklist/domain/parameter/fetch_marklist_parameter.dart';
// import 'package:studentmanagement/fetaures/marklist/presentation/cubit/marklist_cubit.dart';
// import 'package:studentmanagement/services/shared_preference_helper.dart';

// class ExamMarkDetailsPage extends StatefulWidget {
//   final String examTermId;
//   final String examTerm;

//   const ExamMarkDetailsPage({
//     super.key,
//     required this.examTermId,
//     required this.examTerm,
//   });

//   @override
//   State<ExamMarkDetailsPage> createState() => _ExamMarkDetailsPageState();
// }

// class _ExamMarkDetailsPageState extends State<ExamMarkDetailsPage> {
//   final GlobalKey _reportKey = GlobalKey();

//   String classAndDivision = '';
//   Map<String, dynamic>? branchData;
//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() async {
//       loadBranchData();

//       final String? value = await SharedPreferenceHelper()
//           .getClassAndDivision();

//       if (!mounted) return;

//       setState(() {
//         classAndDivision = value ?? '';
//       });

//       context.read<MarklistCubit>().fetchMarkList(
//         FetchMarkListParameter(
//           branchId: 1,
//           accYear: AppData.accYear!,
//           standardId: AppData.studentStdId!.toString(),
//           divisionId: AppData.studentDivId!.toString(),
//           examTermId: widget.examTermId,
//           admno: AppData.admissionNo!.toString(),
//         ),
//       );
//     });
//   }

//   Future<void> loadBranchData() async {
//     final data = await SharedPreferenceHelper().getBranchData();
//     print('BranchDetails $data');
//     debugPrint(data.toString());
//     setState(() {
//       branchData = data;
//     });
//   }

//   void _goBack() {
//     Navigator.pop(context, true);
//     context.read<MarklistCubit>().fetchExamTerms();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (didPop, result) {
//         if (!didPop) _goBack();
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           surfaceTintColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             onPressed: _goBack,
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//           ),
//           title: Text(
//             '${widget.examTerm} Progress Report',
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.download_rounded, color: Colors.black),
//             ),
//           ],
//         ),
//         body: BlocBuilder<MarklistCubit, MarklistState>(
//           builder: (context, state) {
//             if (state is MarkListLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state is MarkListError) {
//               return Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Text(
//                     state.message,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               );
//             }

//             if (state is MarkListLoaded) {
//               final data = state.response.data ?? [];

//               if (data.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     'No Data Found',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 );
//               }

//               return _buildMobileReportScreen(data);
//             }

//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildMobileReportScreen(List<dynamic> data) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.fromLTRB(12, 14, 12, 24),
//       child: RepaintBoundary(
//         key: _reportKey,
//         child: _buildReportMobileUi(data),
//       ),
//     );
//   }

//   Widget _buildReportMobileUi(List<dynamic> data) {
//     final List<_ScholasticRow> rows = _buildScholasticRows(data);

//     final double totalMaxMark = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.maxMark,
//     );

//     final double totalMarkScored = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.markScored,
//     );

//     final double totalOutOf25 = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.marksOutOf25,
//     );

//     final double percentage = totalMaxMark > 0
//         ? (totalMarkScored / totalMaxMark) * 100
//         : 0.0;

//     final String overallGrade = _gradeFromPercentage(percentage);

//     return Container(
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           _buildSchoolHeader(),

//           const SizedBox(height: 16),

//           Text(
//             'PROGRESS REPORT ${_safe(AppData.accYear)}',
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.w900,
//               color: Colors.black,
//             ),
//           ),

//           const SizedBox(height: 10),

//           Center(
//             child: Container(
//               width: 210,
//               height: 34,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.red, width: 1.5),
//               ),
//               child: Text(
//                 widget.examTerm.toUpperCase(),
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w900,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 18),

//           _buildStudentDetails(),

//           const SizedBox(height: 14),

//           _sectionTitle('SCHOLASTIC AREA'),

//           _buildScholasticTable(rows),

//           const SizedBox(height: 10),

//           _buildOverallSummary(
//             overallMarks: totalOutOf25,
//             percentage: percentage,
//             grade: overallGrade,
//           ),

//           const SizedBox(height: 16),

//           _buildActivitySection(
//             title: 'Co-Scholastic Activities',
//             secondTitle: widget.examTerm,
//             rows: const [
//               _ActivityRow('Extra Curricular Activity', 'A'),
//               _ActivityRow('Home Work & Co-operations', 'B'),
//               _ActivityRow('Neatness & Tidiness', 'A'),
//             ],
//           ),

//           const SizedBox(height: 12),

//           _buildActivitySection(
//             title: 'Discipline',
//             secondTitle: widget.examTerm,
//             rows: const [_ActivityRow('Discipline & Moral Values', 'A')],
//           ),

//           const SizedBox(height: 70),
//           _buildSignatureRow(),

//           const SizedBox(height: 12),
//           _buildBottomNotes(),
//         ],
//       ),
//     );
//   }

//   Widget _buildSchoolHeader() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _logoBox(),

//         const SizedBox(width: 8),

//         Expanded(
//           child: Column(
//             children: [
//               Text(
//                 _safe(AppData.branchName).toUpperCase(),
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w900,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               // const Text(
//               //   'Affiliated to CBSE New Delhi Reg.No: 930114',
//               //   textAlign: TextAlign.center,
//               //   style: TextStyle(
//               //     fontSize: 8,
//               //     fontWeight: FontWeight.w800,
//               //     color: Colors.black,
//               //   ),
//               // ),
//               // const SizedBox(height: 4),
//               Text(
//                 AppData.place ?? '',
//                 //  'KAKKAMPARA - Ettikulam, P.O PALAKODE - 670305, KANNUR Dist',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 7.2,
//                   fontWeight: FontWeight.w800,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 4),

//               Column(
//                 children: [
//                   if (branchData!["District"] != null &&
//                       branchData!["District"].toString().trim().isNotEmpty)
//                     Text(
//                       branchData!["District"],
//                       style: const TextStyle(
//                         fontSize: 7.2,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.black,
//                       ),
//                     ),
//                   const SizedBox(height: 2),
//                   if (branchData!["State"] != null &&
//                       branchData!["State"].toString().trim().isNotEmpty)
//                     Text(
//                       branchData!["State"],
//                       style: const TextStyle(
//                         fontSize: 7.2,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.black,
//                       ),
//                     ),
//                   SizedBox(height: 3),
//                   if (branchData!["Email"] != null &&
//                       branchData!["Email"].toString().trim().isNotEmpty)
//                     Text(
//                       'Email: ${branchData!["Email"]}',
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 7.2,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.black,
//                       ),
//                     ),
//                   if (branchData!["Phone"] != null &&
//                       branchData!["Phone"].toString().trim().isNotEmpty)
//                     Text(
//                       'Phone: ${branchData!["Phone"]}',
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 7.2,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.black,
//                       ),
//                     ),
//                 ],
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(width: 8),

//         _logoBox(),
//       ],
//     );
//   }

//   Widget _logoBox() {
//     final String logo = _safe(AppData.logo, '');

//     return Container(
//       width: 54,
//       height: 54,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.black, width: 1),
//       ),
//       child: ClipOval(
//         child: logo.isNotEmpty
//             ? Image.network(
//                 logo,
//                 width: 50,
//                 height: 50,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return _logoFallback();
//                 },
//               )
//             : _logoFallback(),
//       ),
//     );
//   }

//   Widget _logoFallback() {
//     return const Center(
//       child: Text(
//         'LOGO',
//         style: TextStyle(
//           fontSize: 7,
//           fontWeight: FontWeight.w900,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _buildStudentDetails() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: _detailLine(
//                 "Student's Name",
//                 _safe(AppData.studentName, ''),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: _detailLine(
//                 'Adm No',
//                 _safe(AppData.admissionNo, ''),
//                 valueBold: true,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(child: _detailLine('Class', classAndDivision)),
//             const SizedBox(width: 8),
//             Expanded(child: _detailLine('DOB', AppData.dob ?? '')),
//           ],
//         ),

//         // Row(
//         //   children: [
//         //     Expanded(child: _detailLine('Address', '-')),
//         //     const SizedBox(width: 8),
//         //     Expanded(child: _detailLine('Mobile No', '-')),
//         //   ],
//         // ),
//       ],
//     );
//   }

//   Widget _detailLine(String label, String value, {bool valueBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 74,
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 7.4,
//                 fontWeight: FontWeight.w800,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const Text(
//             ':',
//             style: TextStyle(
//               fontSize: 7.4,
//               fontWeight: FontWeight.w900,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(width: 5),
//           Expanded(
//             child: Text(
//               value,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: valueBold ? 15 : 7.8,
//                 fontWeight: valueBold ? FontWeight.w900 : FontWeight.w800,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Container(
//       height: 24,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black, width: 1),
//       ),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 9,
//           fontWeight: FontWeight.w900,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _buildScholasticTable(List<_ScholasticRow> rows) {
//     final double totalMaxMark = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.maxMark,
//     );

//     final double totalMarkScored = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.markScored,
//     );

//     final double totalOutOf25 = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.marksOutOf25,
//     );

//     final double totalPercentage = totalMaxMark > 0
//         ? (totalMarkScored / totalMaxMark) * 100
//         : 0.0;

//     final String totalGrade = _gradeFromPercentage(totalPercentage);

//     return Table(
//       border: TableBorder.all(color: Colors.black, width: 0.8),
//       columnWidths: const {
//         0: FlexColumnWidth(2.45),
//         1: FlexColumnWidth(0.8),
//         2: FlexColumnWidth(0.9),
//         3: FlexColumnWidth(1.12),
//         4: FlexColumnWidth(0.9),
//         5: FlexColumnWidth(0.65),
//       },
//       children: [
//         TableRow(
//           children: [
//             _tableHeader('Subject Name'),
//             _tableHeader('Max. Mark'),
//             _tableHeader('Mark Scored'),
//             _tableHeader('Marks Out of 25'),
//             _tableHeader('Percentage'),
//             _tableHeader('Grade'),
//           ],
//         ),
//         ...rows.map((row) {
//           return TableRow(
//             children: [
//               _tableCell(row.subject, align: TextAlign.left, bold: true),
//               _tableCell(_formatNumber(row.maxMark)),
//               _tableCell(_formatNumber(row.markScored)),
//               _tableCell(_formatNumber(row.marksOutOf25)),
//               _tableCell(_formatNumber(row.percentage)),
//               _tableCell(row.grade, bold: true),
//             ],
//           );
//         }),
//         TableRow(
//           children: [
//             _tableCell('Total', align: TextAlign.left, bold: true),
//             _tableCell(_formatNumber(totalMaxMark), bold: true),
//             _tableCell(_formatNumber(totalMarkScored), bold: true),
//             _tableCell(_formatNumber(totalOutOf25), bold: true),
//             _tableCell(_formatNumber(totalPercentage), bold: true),
//             _tableCell(totalGrade, bold: true),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _tableHeader(String text) {
//     return Container(
//       height: 24,
//       alignment: Alignment.center,
//       padding: const EdgeInsets.symmetric(horizontal: 2),
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: const TextStyle(
//           fontSize: 6.4,
//           fontWeight: FontWeight.w900,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _tableCell(
//     String text, {
//     TextAlign align = TextAlign.center,
//     bool bold = false,
//   }) {
//     return Container(
//       height: 24,
//       alignment: align == TextAlign.left
//           ? Alignment.centerLeft
//           : Alignment.center,
//       padding: const EdgeInsets.symmetric(horizontal: 3),
//       child: Text(
//         text,
//         textAlign: align,
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//           fontSize: 6.7,
//           fontWeight: bold ? FontWeight.w900 : FontWeight.w700,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _buildOverallSummary({
//     required double overallMarks,
//     required double percentage,
//     required String grade,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       child: FittedBox(
//         fit: BoxFit.scaleDown,
//         alignment: Alignment.centerLeft,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             _summaryPair(
//               label: 'Overall Marks',
//               value: '${_formatNumber(overallMarks)} / 100',
//               valueWidth: 78,
//             ),
//             const SizedBox(width: 8),
//             _summaryPair(
//               label: 'Percentage',
//               value: _formatNumber(percentage),
//               valueWidth: 54,
//             ),
//             const SizedBox(width: 8),
//             _summaryPair(label: 'Attendance', value: '-', valueWidth: 54),
//             const SizedBox(width: 8),
//             _summaryPair(label: 'Overall Grade', value: grade, valueWidth: 48),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _summaryPair({
//     required String label,
//     required String value,
//     required double valueWidth,
//   }) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         _summaryLabel(label),
//         const SizedBox(width: 4),
//         _summaryValue(value, width: valueWidth),
//       ],
//     );
//   }

//   Widget _summaryLabel(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 7,
//         fontWeight: FontWeight.w900,
//         color: Colors.black,
//       ),
//     );
//   }

//   Widget _summaryValue(String text, {required double width}) {
//     return Container(
//       width: width,
//       height: 22,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black, width: 1),
//       ),
//       child: Text(
//         text,
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: const TextStyle(
//           fontSize: 7,
//           fontWeight: FontWeight.w900,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _buildActivitySection({
//     required String title,
//     String secondTitle = '',
//     required List<_ActivityRow> rows,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black, width: 1),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 8,
//                   fontWeight: FontWeight.w900,
//                   color: Colors.black,
//                 ),
//               ),
//               Text(
//                 secondTitle,
//                 style: const TextStyle(
//                   fontSize: 8,
//                   fontWeight: FontWeight.w900,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Expanded(
//                 flex: 58,
//                 child: Table(
//                   border: TableBorder.all(color: Colors.black, width: 0.8),
//                   children: [
//                     TableRow(children: [_smallHeader('Activities')]),
//                     ...rows.map((row) {
//                       return TableRow(
//                         children: [
//                           _smallCell(row.activity, align: TextAlign.left),
//                         ],
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Expanded(
//                 flex: 36,
//                 child: Table(
//                   border: TableBorder.all(color: Colors.black, width: 0.8),
//                   children: [
//                     // TableRow(
//                     //   children: [_smallHeader(widget.examTerm.toUpperCase())],
//                     // ),
//                     TableRow(children: [_smallHeader('Grade')]),
//                     ...rows.map((row) {
//                       return TableRow(children: [_smallCell(row.grade)]);
//                     }),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _smallHeader(String text) {
//     return Container(
//       height: 21,
//       alignment: Alignment.center,
//       padding: const EdgeInsets.symmetric(horizontal: 4),
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: const TextStyle(
//           fontSize: 6.8,
//           fontWeight: FontWeight.w900,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _smallCell(String text, {TextAlign align = TextAlign.center}) {
//     return Container(
//       height: 21,
//       alignment: align == TextAlign.left
//           ? Alignment.centerLeft
//           : Alignment.center,
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       child: Text(
//         text,
//         textAlign: align,
//         style: const TextStyle(
//           fontSize: 6.8,
//           fontWeight: FontWeight.w700,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _buildSignatureRow() {
//     return const Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "Class Teacher's Sign",
//           style: TextStyle(
//             fontSize: 7,
//             fontWeight: FontWeight.w800,
//             color: Colors.black,
//           ),
//         ),
//         Text(
//           "Principal's Sign",
//           style: TextStyle(
//             fontSize: 7,
//             fontWeight: FontWeight.w800,
//             color: Colors.black,
//           ),
//         ),
//         Text(
//           "Parent's Sign",
//           style: TextStyle(
//             fontSize: 7,
//             fontWeight: FontWeight.w800,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBottomNotes() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.only(top: 8),
//       decoration: const BoxDecoration(
//         border: Border(top: BorderSide(color: Colors.black, width: 1)),
//       ),
//       child: const Column(
//         children: [
//           Text(
//             'Activities Grade : A = Outstanding, B = Very Good, C = Good, D = Need Improvement',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 6,
//               fontWeight: FontWeight.w900,
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(height: 7),
//           Text(
//             'Mark Vs. Grade : A1=90-100, A2=80-89, B1=70-79, B2=60-69, C1=50-59, C2=40-49, D=33-39',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 6,
//               fontWeight: FontWeight.w900,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   List<_ScholasticRow> _buildScholasticRows(List<dynamic> data) {
//     return List<_ScholasticRow>.generate(data.length, (index) {
//       final dynamic item = data[index];

//       final String subjectName = _safe(
//         item.subjectName,
//         'Subject ${index + 1}',
//       );

//       final double maxMark = _toDouble(item.ce, fallback: 0);
//       final double markScored = _toDouble(item.te, fallback: 0);

//       final double marksOutOf25 = maxMark > 0
//           ? (markScored / maxMark) * 25
//           : 0.0;

//       final double percentage = maxMark > 0
//           ? (markScored / maxMark) * 100
//           : 0.0;

//       final String grade = _safe(item.grade, _gradeFromPercentage(percentage));

//       return _ScholasticRow(
//         subject: subjectName,
//         maxMark: maxMark,
//         markScored: markScored,
//         marksOutOf25: marksOutOf25,
//         percentage: percentage,
//         grade: grade,
//       );
//     });
//   }

//   double _toDouble(dynamic value, {double fallback = 0}) {
//     if (value == null) return fallback;

//     final String text = value.toString().trim();

//     if (text.isEmpty || text.toLowerCase() == 'null') {
//       return fallback;
//     }

//     return double.tryParse(text) ?? fallback;
//   }

//   String _safe(dynamic value, [String fallback = '-']) {
//     final String text = value?.toString().trim() ?? '';

//     if (text.isEmpty || text.toLowerCase() == 'null') {
//       return fallback;
//     }

//     return text;
//   }

//   String _formatNumber(double value) {
//     if (value % 1 == 0) {
//       return value.toInt().toString();
//     }

//     return value.toStringAsFixed(2);
//   }

//   String _gradeFromPercentage(double percentage) {
//     if (percentage >= 90) return 'A1';
//     if (percentage >= 80) return 'A2';
//     if (percentage >= 70) return 'B1';
//     if (percentage >= 60) return 'B2';
//     if (percentage >= 50) return 'C1';
//     if (percentage >= 40) return 'C2';
//     if (percentage >= 33) return 'D';
//     return 'E';
//   }
// }

// class _ScholasticRow {
//   final String subject;
//   final double maxMark;
//   final double markScored;
//   final double marksOutOf25;
//   final double percentage;
//   final String grade;

//   const _ScholasticRow({
//     required this.subject,
//     required this.maxMark,
//     required this.markScored,
//     required this.marksOutOf25,
//     required this.percentage,
//     required this.grade,
//   });
// }

// class _ActivityRow {
//   final String activity;
//   final String grade;

//   const _ActivityRow(this.activity, this.grade);
// }

// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:media_store_plus/media_store_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:studentmanagement/core/appdata/appdata.dart';
// import 'package:studentmanagement/fetaures/marklist/domain/parameter/fetch_marklist_parameter.dart';
// import 'package:studentmanagement/fetaures/marklist/presentation/cubit/marklist_cubit.dart';
// import 'package:studentmanagement/services/shared_preference_helper.dart';

// class ExamMarkDetailsPage extends StatefulWidget {
//   final String examTermId;
//   final String examTerm;

//   const ExamMarkDetailsPage({
//     super.key,
//     required this.examTermId,
//     required this.examTerm,
//   });

//   @override
//   State<ExamMarkDetailsPage> createState() => _ExamMarkDetailsPageState();
// }

// class _ExamMarkDetailsPageState extends State<ExamMarkDetailsPage> {
//   String classAndDivision = '';
//   Map<String, dynamic>? branchData;

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() async {
//       final String? value = await SharedPreferenceHelper()
//           .getClassAndDivision();

//       final Map<String, dynamic>? savedBranchData =
//           await SharedPreferenceHelper().getBranchData();

//       if (!mounted) return;

//       setState(() {
//         classAndDivision = value ?? '';
//         branchData = savedBranchData;
//       });

//       context.read<MarklistCubit>().fetchMarkList(
//         FetchMarkListParameter(
//           branchId: 1,
//           accYear: AppData.accYear!,
//           standardId: AppData.studentStdId!.toString(),
//           divisionId: AppData.studentDivId!.toString(),
//           examTermId: widget.examTermId,
//           admno: AppData.admissionNo!.toString(),
//         ),
//       );
//     });
//   }

//   void _goBack() {
//     final MarklistCubit marklistCubit = context.read<MarklistCubit>();

//     Navigator.pop(context, true);

//     marklistCubit.fetchExamTerms();
//   }

//   Future<void> generateAndDownloadPdf() async {
//     try {
//       final currentState = context.read<MarklistCubit>().state;

//       if (currentState is! MarkListLoaded) {
//         _showMessage('No report data available to download.');
//         return;
//       }

//       final List<dynamic> data = currentState.response.data ?? [];

//       if (data.isEmpty) {
//         _showMessage('No report data available to download.');
//         return;
//       }

//       final List<_ScholasticRow> rows = _buildScholasticRows(data);

//       final double totalMaxMark = rows.fold<double>(
//         0,
//         (sum, row) => sum + row.maxMark,
//       );

//       final double totalMarkScored = rows.fold<double>(
//         0,
//         (sum, row) => sum + row.markScored,
//       );

//       final double totalOutOf25 = rows.fold<double>(
//         0,
//         (sum, row) => sum + row.marksOutOf25,
//       );

//       final double percentage = totalMaxMark > 0
//           ? (totalMarkScored / totalMaxMark) * 100
//           : 0.0;

//       final String overallGrade = _gradeFromPercentage(percentage);
//       final String attendanceStatus = _getAttendanceStatus(data);

//       final pw.Document pdf = pw.Document();

//       final pw.MemoryImage? logo = await _loadPdfLogo();

//       pdf.addPage(
//         pw.Page(
//           pageFormat: PdfPageFormat.a4,
//           margin: const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 24),
//           build: (pw.Context context) {
//             return pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.stretch,
//               children: [
//                 _pdfSchoolHeader(logo),

//                 pw.SizedBox(height: 18),

//                 pw.Text(
//                   'PROGRESS REPORT ${_safe(AppData.accYear)}',
//                   textAlign: pw.TextAlign.center,
//                   style: pw.TextStyle(
//                     fontSize: 17,
//                     fontWeight: pw.FontWeight.bold,
//                   ),
//                 ),

//                 pw.SizedBox(height: 10),

//                 pw.Center(
//                   child: pw.Container(
//                     width: 210,
//                     height: 34,
//                     alignment: pw.Alignment.center,
//                     decoration: pw.BoxDecoration(
//                       border: pw.Border.all(color: PdfColors.red, width: 1.5),
//                     ),
//                     child: pw.Text(
//                       widget.examTerm.toUpperCase(),
//                       textAlign: pw.TextAlign.center,
//                       style: pw.TextStyle(
//                         fontSize: 13,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),

//                 pw.SizedBox(height: 18),

//                 _pdfStudentDetails(data),

//                 pw.SizedBox(height: 14),

//                 _pdfSectionTitle('SCHOLASTIC AREA'),

//                 _pdfScholasticTable(rows),

//                 pw.SizedBox(height: 10),

//                 _pdfOverallSummary(
//                   overallMarks: totalOutOf25,
//                   percentage: percentage,
//                   attendance: attendanceStatus,
//                   grade: overallGrade,
//                 ),

//                 pw.SizedBox(height: 16),

//                 _pdfActivitySection(
//                   title: 'Co-Scholastic Activities',
//                   secondTitle: widget.examTerm,
//                   rows: const [
//                     _ActivityRow('Extra Curricular Activity', 'A'),
//                     _ActivityRow('Home Work & Co-operations', 'B'),
//                     _ActivityRow('Neatness & Tidiness', 'A'),
//                   ],
//                 ),

//                 pw.SizedBox(height: 12),

//                 _pdfActivitySection(
//                   title: 'Discipline',
//                   secondTitle: widget.examTerm,
//                   rows: const [_ActivityRow('Discipline & Moral Values', 'A')],
//                 ),

//                 pw.Spacer(),

//                 _pdfSignatureRow(),

//                 pw.SizedBox(height: 14),

//                 _pdfBottomNotes(),

//                 pw.SizedBox(height: 8),

//                 pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                   children: [
//                     pw.Text(
//                       'Generated by Cristal',
//                       style: const pw.TextStyle(fontSize: 6),
//                     ),
//                     pw.Text(
//                       'Page ${context.pageNumber}/${context.pagesCount}',
//                       style: const pw.TextStyle(fontSize: 6),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       );

//       final String safeExamTerm = widget.examTerm
//           .trim()
//           .replaceAll(RegExp(r'[^A-Za-z0-9_ -]'), '')
//           .replaceAll(' ', '_');

//       final String fileName =
//           'Progress_Report_${safeExamTerm}_${DateTime.now().millisecondsSinceEpoch}.pdf';

//       final Directory tempDir = await getTemporaryDirectory();
//       final File tempFile = File('${tempDir.path}/$fileName');

//       await tempFile.writeAsBytes(await pdf.save());

//       await MediaStore.ensureInitialized();

//       MediaStore.appFolder = 'Cristal';

//       final MediaStore mediaStore = MediaStore();

//       final result = await mediaStore.saveFile(
//         tempFilePath: tempFile.path,
//         dirType: DirType.download,
//         dirName: DirName.download,
//       );

//       if (!mounted) return;

//       if (result != null) {
//         _showMessage('PDF saved in Downloads/Cristal ✔');
//       } else {
//         throw Exception('Save failed');
//       }
//     } catch (e) {
//       debugPrint('PDF ERROR: $e');

//       if (!mounted) return;

//       _showMessage('Failed to save PDF: $e');
//     }
//   }

//   Future<pw.MemoryImage?> _loadPdfLogo() async {
//     try {
//       final String logoUrl = _safe(
//         _branchValue(['Logo', 'logo'], fallback: AppData.logo),
//         '',
//       );

//       if (logoUrl.isEmpty) return null;

//       if (logoUrl.startsWith('http')) {
//         final response = await http.get(Uri.parse(logoUrl));

//         if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
//           return pw.MemoryImage(response.bodyBytes);
//         }

//         return null;
//       }

//       final ByteData data = await rootBundle.load(logoUrl);
//       return pw.MemoryImage(data.buffer.asUint8List());
//     } catch (e) {
//       debugPrint('LOGO LOAD ERROR: $e');
//       return null;
//     }
//   }

//   void _showMessage(String message) {
//     if (!mounted) return;

//     ScaffoldMessenger.of(context)
//       ..clearSnackBars()
//       ..showSnackBar(
//         SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (didPop, result) {
//         if (!didPop) _goBack();
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           surfaceTintColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             onPressed: _goBack,
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//           ),
//           title: Text(
//             '${widget.examTerm} Progress Report',
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           actions: [
//             IconButton(
//               onPressed: generateAndDownloadPdf,
//               icon: const Icon(Icons.download_rounded, color: Colors.black),
//             ),
//           ],
//         ),
//         body: BlocBuilder<MarklistCubit, MarklistState>(
//           builder: (context, state) {
//             if (state is MarkListLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state is MarkListError) {
//               return Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Text(
//                     state.message,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               );
//             }

//             if (state is MarkListLoaded) {
//               final List<dynamic> data = state.response.data ?? [];

//               if (data.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     'No Data Found',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 );
//               }

//               return _buildMobileReportScreen(data);
//             }

//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildMobileReportScreen(List<dynamic> data) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.fromLTRB(12, 14, 12, 24),
//       child: _buildReportMobileUi(data),
//     );
//   }

//   Widget _buildReportMobileUi(List<dynamic> data) {
//     final List<_ScholasticRow> rows = _buildScholasticRows(data);

//     final double totalMaxMark = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.maxMark,
//     );

//     final double totalMarkScored = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.markScored,
//     );

//     final double totalOutOf25 = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.marksOutOf25,
//     );

//     final double percentage = totalMaxMark > 0
//         ? (totalMarkScored / totalMaxMark) * 100
//         : 0.0;

//     final String overallGrade = _gradeFromPercentage(percentage);
//     final String attendanceStatus = _getAttendanceStatus(data);

//     return Container(
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           _buildSchoolHeader(),

//           const SizedBox(height: 16),

//           Text(
//             'PROGRESS REPORT ${_safe(AppData.accYear)}',
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.w900,
//               color: Colors.black,
//             ),
//           ),

//           const SizedBox(height: 10),

//           Center(
//             child: Container(
//               width: 210,
//               height: 34,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.red, width: 1.5),
//               ),
//               child: Text(
//                 widget.examTerm.toUpperCase(),
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w900,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 18),

//           _buildStudentDetails(data),

//           const SizedBox(height: 14),

//           _sectionTitle('SCHOLASTIC AREA'),

//           _buildScholasticTable(rows),

//           const SizedBox(height: 10),

//           _buildOverallSummary(
//             overallMarks: totalOutOf25,
//             percentage: percentage,
//             attendance: attendanceStatus,
//             grade: overallGrade,
//           ),

//           const SizedBox(height: 16),

//           // _buildActivitySection(
//           //   title: 'Co-Scholastic Activities',
//           //   secondTitle: widget.examTerm,
//           //   rows: const [
//           //     _ActivityRow('Extra Curricular Activity', 'A'),
//           //     _ActivityRow('Home Work & Co-operations', 'B'),
//           //     _ActivityRow('Neatness & Tidiness', 'A'),
//           //   ],
//           // ),

//           // const SizedBox(height: 12),

//           // _buildActivitySection(
//           //   title: 'Discipline',
//           //   secondTitle: widget.examTerm,
//           //   rows: const [_ActivityRow('Discipline & Moral Values', 'A')],
//           // ),

//           // const SizedBox(height: 90),

//           // _buildSignatureRow(),

//           // const SizedBox(height: 12),

//           // _buildBottomNotes(),
//         ],
//       ),
//     );
//   }

//   Widget _buildSchoolHeader() {
//     final String branchName = _safe(
//       _branchValue([
//         'BranchName',
//         'branchName',
//         'branch_name',
//       ], fallback: AppData.branchName),
//       '',
//     );

//     final String place = _safe(
//       _branchValue(['Place', 'place'], fallback: AppData.place),
//       '',
//     );

//     final String postPin = _branchValue([
//       'Post_Pin',
//       'post_Pin',
//       'postPin',
//       'PostPin',
//       'post_pin',
//       'PIN',
//       'pin',
//     ]);

//     final String district = _branchValue(['District', 'district']);

//     final String state = _branchValue(['State', 'state']);

//     final String email = _branchValue(['Email', 'email']);

//     final String phone = _branchValue([
//       'Phone',
//       'phone',
//       'Phone1',
//       'phone1',
//       'Mobile',
//       'mobile',
//     ]);

//     final String addressText = _joinNonEmpty([place, postPin, district, state]);

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _logoBox(),

//         const SizedBox(width: 8),

//         Expanded(
//           child: Column(
//             children: [
//               Text(
//                 branchName.toUpperCase(),
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w900,
//                   color: Colors.black,
//                 ),
//               ),

//               if (addressText.isNotEmpty) ...[
//                 const SizedBox(height: 6),
//                 Text(
//                   addressText,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 7.2,
//                     fontWeight: FontWeight.w800,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],

//               if (email.isNotEmpty) ...[
//                 const SizedBox(height: 3),
//                 Text(
//                   'Email: $email',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 7.2,
//                     fontWeight: FontWeight.w800,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],

//               if (phone.isNotEmpty) ...[
//                 const SizedBox(height: 3),
//                 Text(
//                   'Phone: $phone',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 7.2,
//                     fontWeight: FontWeight.w800,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),

//         const SizedBox(width: 8),

//         _logoBox(),
//       ],
//     );
//   }

//   Widget _logoBox() {
//     final String logo = _safe(
//       _branchValue(['Logo', 'logo'], fallback: AppData.logo),
//       '',
//     );

//     return Container(
//       width: 54,
//       height: 54,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.black, width: 1),
//       ),
//       child: ClipOval(
//         child: logo.isNotEmpty
//             ? Image.network(
//                 logo,
//                 width: 50,
//                 height: 50,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return _logoFallback();
//                 },
//               )
//             : _logoFallback(),
//       ),
//     );
//   }

//   Widget _logoFallback() {
//     return const Center(
//       child: Text(
//         'LOGO',
//         style: TextStyle(
//           fontSize: 7,
//           fontWeight: FontWeight.w900,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _buildStudentDetails(List<dynamic> data) {
//     final String studentName = _getStudentName(data);
//     final String admissionNo = _getAdmissionNo(data);
//     final String gender = _getGender(data);

//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(child: _detailLine("Student's Name", studentName)),
//             const SizedBox(width: 8),
//             Expanded(
//               child: _detailLine('Adm No', admissionNo, valueBold: true),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(child: _detailLine('Class', classAndDivision)),
//             const SizedBox(width: 8),
//             Expanded(child: _detailLine('DOB', AppData.dob ?? '')),
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(child: _detailLine('Gender', gender)),
//             const SizedBox(width: 8),
//             Expanded(child: _detailLine('Absent', _getAbsentText(data))),
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(child: _detailLine('Fathers Name', gender)),
//             const SizedBox(width: 8),
//             Expanded(child: _detailLine('Mothers Name', _getAbsentText(data))),
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(child: _detailLine('Address', gender)),
//             const SizedBox(width: 8),
//             Expanded(child: _detailLine('Mobile Number', _getAbsentText(data))),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _detailLine(String label, String value, {bool valueBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 74,
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 7.4,
//                 fontWeight: FontWeight.w800,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const Text(
//             ':',
//             style: TextStyle(
//               fontSize: 7.4,
//               fontWeight: FontWeight.w900,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(width: 5),
//           Expanded(
//             child: Text(
//               value,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: valueBold ? 15 : 7.8,
//                 fontWeight: valueBold ? FontWeight.w900 : FontWeight.w800,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Container(
//       height: 24,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black, width: 1),
//       ),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 9,
//           fontWeight: FontWeight.w900,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _buildScholasticTable(List<_ScholasticRow> rows) {
//     final double totalMaxMark = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.maxMark,
//     );

//     final double totalMarkScored = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.markScored,
//     );

//     final double totalOutOf25 = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.marksOutOf25,
//     );

//     final double totalPercentage = totalMaxMark > 0
//         ? (totalMarkScored / totalMaxMark) * 100
//         : 0.0;

//     final String totalGrade = _gradeFromPercentage(totalPercentage);

//     return Table(
//       border: TableBorder.all(color: Colors.black, width: 0.8),
//       columnWidths: const {
//         0: FlexColumnWidth(2.45),
//         1: FlexColumnWidth(0.8),
//         2: FlexColumnWidth(0.9),
//         3: FlexColumnWidth(1.12),
//         4: FlexColumnWidth(0.9),
//         5: FlexColumnWidth(0.65),
//       },
//       children: [
//         TableRow(
//           children: [
//             _tableHeader('Subject Name'),
//             _tableHeader('Max. Mark'),
//             _tableHeader('Mark Scored'),
//             _tableHeader('Marks Out of 25'),
//             _tableHeader('Percentage'),
//             _tableHeader('Grade'),
//           ],
//         ),
//         ...rows.map((row) {
//           return TableRow(
//             children: [
//               _tableCell(row.subject, align: TextAlign.left, bold: true),
//               _tableCell(_formatNumber(row.maxMark)),
//               _tableCell(_formatNumber(row.markScored)),
//               _tableCell(_formatNumber(row.marksOutOf25)),
//               _tableCell(_formatNumber(row.percentage)),
//               _tableCell(row.grade, bold: true),
//             ],
//           );
//         }),
//         TableRow(
//           children: [
//             _tableCell('Total', align: TextAlign.left, bold: true),
//             _tableCell(_formatNumber(totalMaxMark), bold: true),
//             _tableCell(_formatNumber(totalMarkScored), bold: true),
//             _tableCell(_formatNumber(totalOutOf25), bold: true),
//             _tableCell(_formatNumber(totalPercentage), bold: true),
//             _tableCell(totalGrade, bold: true),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _tableHeader(String text) {
//     return Container(
//       height: 24,
//       alignment: Alignment.center,
//       padding: const EdgeInsets.symmetric(horizontal: 2),
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: const TextStyle(
//           fontSize: 6.4,
//           fontWeight: FontWeight.w900,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _tableCell(
//     String text, {
//     TextAlign align = TextAlign.center,
//     bool bold = false,
//   }) {
//     return Container(
//       height: 24,
//       alignment: align == TextAlign.left
//           ? Alignment.centerLeft
//           : Alignment.center,
//       padding: const EdgeInsets.symmetric(horizontal: 3),
//       child: Text(
//         text,
//         textAlign: align,
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//           fontSize: 6.7,
//           fontWeight: bold ? FontWeight.w900 : FontWeight.w700,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _buildOverallSummary({
//     required double overallMarks,
//     required double percentage,
//     required String attendance,
//     required String grade,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       child: FittedBox(
//         fit: BoxFit.scaleDown,
//         alignment: Alignment.centerLeft,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             _summaryPair(
//               label: 'Overall Marks',
//               value: '${_formatNumber(overallMarks)} / 100',
//               valueWidth: 78,
//             ),
//             const SizedBox(width: 8),
//             _summaryPair(
//               label: 'Percentage',
//               value: _formatNumber(percentage),
//               valueWidth: 54,
//             ),
//             const SizedBox(width: 8),
//             _summaryPair(
//               label: 'Attendance',
//               value: attendance,
//               valueWidth: 54,
//             ),
//             const SizedBox(width: 8),
//             _summaryPair(label: 'Overall Grade', value: grade, valueWidth: 48),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _summaryPair({
//     required String label,
//     required String value,
//     required double valueWidth,
//   }) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         _summaryLabel(label),
//         const SizedBox(width: 4),
//         _summaryValue(value, width: valueWidth),
//       ],
//     );
//   }

//   Widget _summaryLabel(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 7,
//         fontWeight: FontWeight.w900,
//         color: Colors.black,
//       ),
//     );
//   }

//   Widget _summaryValue(String text, {required double width}) {
//     return Container(
//       width: width,
//       height: 22,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black, width: 1),
//       ),
//       child: Text(
//         text,
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: const TextStyle(
//           fontSize: 7,
//           fontWeight: FontWeight.w900,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   // Widget _buildActivitySection({
//   //   required String title,
//   //   String secondTitle = '',
//   //   required List<_ActivityRow> rows,
//   // }) {
//   //   return Container(
//   //     width: double.infinity,
//   //     padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
//   //     decoration: BoxDecoration(
//   //       border: Border.all(color: Colors.black, width: 1),
//   //     ),
//   //     child: Column(
//   //       children: [
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //           children: [
//   //             Text(
//   //               title,
//   //               style: const TextStyle(
//   //                 fontSize: 8,
//   //                 fontWeight: FontWeight.w900,
//   //                 color: Colors.black,
//   //               ),
//   //             ),
//   //             Text(
//   //               secondTitle,
//   //               style: const TextStyle(
//   //                 fontSize: 8,
//   //                 fontWeight: FontWeight.w900,
//   //                 color: Colors.black,
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //         const SizedBox(height: 8),
//   //         Row(
//   //           children: [
//   //             Expanded(
//   //               flex: 58,
//   //               child: Table(
//   //                 border: TableBorder.all(color: Colors.black, width: 0.8),
//   //                 children: [
//   //                   TableRow(children: [_smallHeader('Activities')]),
//   //                   ...rows.map((row) {
//   //                     return TableRow(
//   //                       children: [
//   //                         _smallCell(row.activity, align: TextAlign.left),
//   //                       ],
//   //                     );
//   //                   }),
//   //                 ],
//   //               ),
//   //             ),
//   //             const SizedBox(width: 20),
//   //             Expanded(
//   //               flex: 36,
//   //               child: Table(
//   //                 border: TableBorder.all(color: Colors.black, width: 0.8),
//   //                 children: [
//   //                   TableRow(children: [_smallHeader('Grade')]),
//   //                   ...rows.map((row) {
//   //                     return TableRow(children: [_smallCell(row.grade)]);
//   //                   }),
//   //                 ],
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // Widget _smallHeader(String text) {
//   //   return Container(
//   //     height: 21,
//   //     alignment: Alignment.center,
//   //     padding: const EdgeInsets.symmetric(horizontal: 4),
//   //     child: Text(
//   //       text,
//   //       textAlign: TextAlign.center,
//   //       style: const TextStyle(
//   //         fontSize: 6.8,
//   //         fontWeight: FontWeight.w900,
//   //         color: Colors.black,
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget _smallCell(String text, {TextAlign align = TextAlign.center}) {
//   //   return Container(
//   //     height: 21,
//   //     alignment: align == TextAlign.left
//   //         ? Alignment.centerLeft
//   //         : Alignment.center,
//   //     padding: const EdgeInsets.symmetric(horizontal: 5),
//   //     child: Text(
//   //       text,
//   //       textAlign: align,
//   //       style: const TextStyle(
//   //         fontSize: 6.8,
//   //         fontWeight: FontWeight.w700,
//   //         color: Colors.black,
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget _buildSignatureRow() {
//   //   return const Row(
//   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //     children: [
//   //       Text(
//   //         "Class Teacher's Sign",
//   //         style: TextStyle(
//   //           fontSize: 7,
//   //           fontWeight: FontWeight.w800,
//   //           color: Colors.black,
//   //         ),
//   //       ),
//   //       Text(
//   //         "Principal's Sign",
//   //         style: TextStyle(
//   //           fontSize: 7,
//   //           fontWeight: FontWeight.w800,
//   //           color: Colors.black,
//   //         ),
//   //       ),
//   //       Text(
//   //         "Parent's Sign",
//   //         style: TextStyle(
//   //           fontSize: 7,
//   //           fontWeight: FontWeight.w800,
//   //           color: Colors.black,
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }

//   // Widget _buildBottomNotes() {
//   //   return Container(
//   //     width: double.infinity,
//   //     padding: const EdgeInsets.only(top: 8),
//   //     decoration: const BoxDecoration(
//   //       border: Border(top: BorderSide(color: Colors.black, width: 1)),
//   //     ),
//   //     child: const Column(
//   //       children: [
//   //         Text(
//   //           'Activities Grade : A = Outstanding, B = Very Good, C = Good, D = Need Improvement',
//   //           textAlign: TextAlign.center,
//   //           style: TextStyle(
//   //             fontSize: 6,
//   //             fontWeight: FontWeight.w900,
//   //             color: Colors.black,
//   //           ),
//   //         ),
//   //         SizedBox(height: 7),
//   //         Text(
//   //           'Mark Vs. Grade : A1=90-100, A2=80-89, B1=70-79, B2=60-69, C1=50-59, C2=40-49, D=33-39',
//   //           textAlign: TextAlign.center,
//   //           style: TextStyle(
//   //             fontSize: 6,
//   //             fontWeight: FontWeight.w900,
//   //             color: Colors.black,
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   pw.Widget _pdfSchoolHeader(pw.MemoryImage? logo) {
//     final String branchName = _safe(
//       _branchValue([
//         'BranchName',
//         'branchName',
//         'branch_name',
//       ], fallback: AppData.branchName),
//       '',
//     );

//     final String place = _safe(
//       _branchValue(['Place', 'place'], fallback: AppData.place),
//       '',
//     );

//     final String postPin = _branchValue([
//       'Post_Pin',
//       'post_Pin',
//       'postPin',
//       'PostPin',
//       'post_pin',
//       'PIN',
//       'pin',
//     ]);

//     final String district = _branchValue(['District', 'district']);

//     final String state = _branchValue(['State', 'state']);

//     final String email = _branchValue(['Email', 'email']);

//     final String phone = _branchValue([
//       'Phone',
//       'phone',
//       'Phone1',
//       'phone1',
//       'Mobile',
//       'mobile',
//     ]);

//     final String addressText = _joinNonEmpty([place, postPin, district, state]);

//     return pw.Row(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         _pdfLogoBox(logo),

//         pw.SizedBox(width: 8),

//         pw.Expanded(
//           child: pw.Column(
//             children: [
//               pw.Text(
//                 branchName.toUpperCase(),
//                 textAlign: pw.TextAlign.center,
//                 style: pw.TextStyle(
//                   fontSize: 15,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),

//               if (addressText.isNotEmpty) ...[
//                 pw.SizedBox(height: 6),
//                 pw.Text(
//                   addressText,
//                   textAlign: pw.TextAlign.center,
//                   style: pw.TextStyle(
//                     fontSize: 8,
//                     fontWeight: pw.FontWeight.bold,
//                   ),
//                 ),
//               ],

//               if (email.isNotEmpty) ...[
//                 pw.SizedBox(height: 3),
//                 pw.Text(
//                   'Email: $email',
//                   textAlign: pw.TextAlign.center,
//                   style: pw.TextStyle(
//                     fontSize: 8,
//                     fontWeight: pw.FontWeight.bold,
//                   ),
//                 ),
//               ],

//               if (phone.isNotEmpty) ...[
//                 pw.SizedBox(height: 3),
//                 pw.Text(
//                   'Phone: $phone',
//                   textAlign: pw.TextAlign.center,
//                   style: pw.TextStyle(
//                     fontSize: 8,
//                     fontWeight: pw.FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),

//         pw.SizedBox(width: 8),

//         _pdfLogoBox(logo),
//       ],
//     );
//   }

//   pw.Widget _pdfLogoBox(pw.MemoryImage? logo) {
//     return pw.Container(
//       width: 54,
//       height: 54,
//       alignment: pw.Alignment.center,
//       decoration: pw.BoxDecoration(
//         shape: pw.BoxShape.circle,
//         border: pw.Border.all(color: PdfColors.black, width: 1),
//       ),
//       child: logo != null
//           ? pw.ClipOval(
//               child: pw.Image(
//                 logo,
//                 width: 50,
//                 height: 50,
//                 fit: pw.BoxFit.cover,
//               ),
//             )
//           : pw.Text(
//               'LOGO',
//               style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
//             ),
//     );
//   }

//   pw.Widget _pdfStudentDetails(List<dynamic> data) {
//     return pw.Column(
//       children: [
//         pw.Row(
//           children: [
//             pw.Expanded(
//               child: _pdfDetailLine("Student's Name", _getStudentName(data)),
//             ),
//             pw.SizedBox(width: 8),
//             pw.Expanded(
//               child: _pdfDetailLine(
//                 'Adm No',
//                 _getAdmissionNo(data),
//                 valueBold: true,
//               ),
//             ),
//           ],
//         ),
//         pw.Row(
//           children: [
//             pw.Expanded(child: _pdfDetailLine('Class', classAndDivision)),
//             pw.SizedBox(width: 8),
//             pw.Expanded(child: _pdfDetailLine('DOB', AppData.dob ?? '')),
//           ],
//         ),
//         pw.Row(
//           children: [
//             pw.Expanded(child: _pdfDetailLine('Gender', _getGender(data))),
//             pw.SizedBox(width: 8),
//             pw.Expanded(child: _pdfDetailLine('Absent', _getAbsentText(data))),
//           ],
//         ),
//         pw.Row(
//           children: [
//             pw.Expanded(
//               child: _pdfDetailLine('Fathers Name', _getGender(data)),
//             ),
//             pw.SizedBox(width: 8),
//             pw.Expanded(
//               child: _pdfDetailLine('Mothers Name', _getAbsentText(data)),
//             ),
//           ],
//         ),
//         pw.Row(
//           children: [
//             pw.Expanded(child: _pdfDetailLine('Address', _getGender(data))),
//             pw.SizedBox(width: 8),
//             pw.Expanded(
//               child: _pdfDetailLine('Phone No', _getAbsentText(data)),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   pw.Widget _pdfDetailLine(
//     String label,
//     String value, {
//     bool valueBold = false,
//   }) {
//     return pw.Padding(
//       padding: const pw.EdgeInsets.only(bottom: 6),
//       child: pw.Row(
//         children: [
//           pw.SizedBox(
//             width: 74,
//             child: pw.Text(
//               label,
//               style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
//             ),
//           ),
//           pw.Text(
//             ':',
//             style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
//           ),
//           pw.SizedBox(width: 5),
//           pw.Expanded(
//             child: pw.Text(
//               value,
//               maxLines: 1,
//               style: pw.TextStyle(
//                 fontSize: valueBold ? 12 : 8,
//                 fontWeight: valueBold
//                     ? pw.FontWeight.bold
//                     : pw.FontWeight.normal,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   pw.Widget _pdfSectionTitle(String title) {
//     return pw.Container(
//       height: 24,
//       alignment: pw.Alignment.center,
//       decoration: pw.BoxDecoration(
//         border: pw.Border.all(color: PdfColors.black, width: 1),
//       ),
//       child: pw.Text(
//         title,
//         style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
//       ),
//     );
//   }

//   pw.Widget _pdfScholasticTable(List<_ScholasticRow> rows) {
//     final double totalMaxMark = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.maxMark,
//     );

//     final double totalMarkScored = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.markScored,
//     );

//     final double totalOutOf25 = rows.fold<double>(
//       0,
//       (sum, row) => sum + row.marksOutOf25,
//     );

//     final double totalPercentage = totalMaxMark > 0
//         ? (totalMarkScored / totalMaxMark) * 100
//         : 0.0;

//     final String totalGrade = _gradeFromPercentage(totalPercentage);

//     return pw.Table(
//       border: pw.TableBorder.all(color: PdfColors.black, width: 0.8),
//       columnWidths: {
//         0: const pw.FlexColumnWidth(2.45),
//         1: const pw.FlexColumnWidth(0.8),
//         2: const pw.FlexColumnWidth(0.9),
//         3: const pw.FlexColumnWidth(1.12),
//         4: const pw.FlexColumnWidth(0.9),
//         5: const pw.FlexColumnWidth(0.65),
//       },
//       children: [
//         pw.TableRow(
//           children: [
//             _pdfTableHeader('Subject Name'),
//             _pdfTableHeader('Max. Mark'),
//             _pdfTableHeader('Mark Scored'),
//             _pdfTableHeader('Marks Out of 25'),
//             _pdfTableHeader('Percentage'),
//             _pdfTableHeader('Grade'),
//           ],
//         ),
//         ...rows.map((row) {
//           return pw.TableRow(
//             children: [
//               _pdfTableCell(row.subject, alignLeft: true, bold: true),
//               _pdfTableCell(_formatNumber(row.maxMark)),
//               _pdfTableCell(_formatNumber(row.markScored)),
//               _pdfTableCell(_formatNumber(row.marksOutOf25)),
//               _pdfTableCell(_formatNumber(row.percentage)),
//               _pdfTableCell(row.grade, bold: true),
//             ],
//           );
//         }),
//         pw.TableRow(
//           children: [
//             _pdfTableCell('Total', alignLeft: true, bold: true),
//             _pdfTableCell(_formatNumber(totalMaxMark), bold: true),
//             _pdfTableCell(_formatNumber(totalMarkScored), bold: true),
//             _pdfTableCell(_formatNumber(totalOutOf25), bold: true),
//             _pdfTableCell(_formatNumber(totalPercentage), bold: true),
//             _pdfTableCell(totalGrade, bold: true),
//           ],
//         ),
//       ],
//     );
//   }

//   pw.Widget _pdfTableHeader(String text) {
//     return pw.Container(
//       height: 24,
//       alignment: pw.Alignment.center,
//       padding: const pw.EdgeInsets.symmetric(horizontal: 2),
//       child: pw.Text(
//         text,
//         textAlign: pw.TextAlign.center,
//         style: pw.TextStyle(fontSize: 6.6, fontWeight: pw.FontWeight.bold),
//       ),
//     );
//   }

//   pw.Widget _pdfTableCell(
//     String text, {
//     bool alignLeft = false,
//     bool bold = false,
//   }) {
//     return pw.Container(
//       height: 24,
//       alignment: alignLeft ? pw.Alignment.centerLeft : pw.Alignment.center,
//       padding: const pw.EdgeInsets.symmetric(horizontal: 3),
//       child: pw.Text(
//         text,
//         textAlign: alignLeft ? pw.TextAlign.left : pw.TextAlign.center,
//         maxLines: 1,
//         style: pw.TextStyle(
//           fontSize: 6.8,
//           fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
//         ),
//       ),
//     );
//   }

//   pw.Widget _pdfOverallSummary({
//     required double overallMarks,
//     required double percentage,
//     required String attendance,
//     required String grade,
//   }) {
//     return pw.Row(
//       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//       children: [
//         _pdfSummaryPair(
//           label: 'Overall Marks',
//           value: '${_formatNumber(overallMarks)} / 100',
//           valueWidth: 78,
//         ),
//         _pdfSummaryPair(
//           label: 'Percentage',
//           value: _formatNumber(percentage),
//           valueWidth: 54,
//         ),
//         _pdfSummaryPair(label: 'Attendance', value: attendance, valueWidth: 54),
//         _pdfSummaryPair(label: 'Overall Grade', value: grade, valueWidth: 48),
//       ],
//     );
//   }

//   pw.Widget _pdfSummaryPair({
//     required String label,
//     required String value,
//     required double valueWidth,
//   }) {
//     return pw.Row(
//       mainAxisSize: pw.MainAxisSize.min,
//       children: [
//         pw.Text(
//           label,
//           style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(width: 4),
//         pw.Container(
//           width: valueWidth,
//           height: 22,
//           alignment: pw.Alignment.center,
//           decoration: pw.BoxDecoration(
//             border: pw.Border.all(color: PdfColors.black, width: 1),
//           ),
//           child: pw.Text(
//             value,
//             style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }

//   pw.Widget _pdfActivitySection({
//     required String title,
//     String secondTitle = '',
//     required List<_ActivityRow> rows,
//   }) {
//     return pw.Container(
//       width: double.infinity,
//       padding: const pw.EdgeInsets.fromLTRB(12, 8, 12, 10),
//       decoration: pw.BoxDecoration(
//         border: pw.Border.all(color: PdfColors.black, width: 1),
//       ),
//       child: pw.Column(
//         children: [
//           pw.Row(
//             mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//             children: [
//               pw.Text(
//                 title,
//                 style: pw.TextStyle(
//                   fontSize: 8,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//               pw.Text(
//                 secondTitle,
//                 style: pw.TextStyle(
//                   fontSize: 8,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           pw.SizedBox(height: 8),
//           pw.Row(
//             children: [
//               pw.Expanded(
//                 flex: 58,
//                 child: pw.Table(
//                   border: pw.TableBorder.all(
//                     color: PdfColors.black,
//                     width: 0.8,
//                   ),
//                   children: [
//                     pw.TableRow(children: [_pdfSmallHeader('Activities')]),
//                     ...rows.map((row) {
//                       return pw.TableRow(
//                         children: [
//                           _pdfSmallCell(row.activity, alignLeft: true),
//                         ],
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(width: 20),
//               pw.Expanded(
//                 flex: 36,
//                 child: pw.Table(
//                   border: pw.TableBorder.all(
//                     color: PdfColors.black,
//                     width: 0.8,
//                   ),
//                   children: [
//                     pw.TableRow(children: [_pdfSmallHeader('Grade')]),
//                     ...rows.map((row) {
//                       return pw.TableRow(children: [_pdfSmallCell(row.grade)]);
//                     }),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   pw.Widget _pdfSmallHeader(String text) {
//     return pw.Container(
//       height: 21,
//       alignment: pw.Alignment.center,
//       padding: const pw.EdgeInsets.symmetric(horizontal: 4),
//       child: pw.Text(
//         text,
//         textAlign: pw.TextAlign.center,
//         style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
//       ),
//     );
//   }

//   pw.Widget _pdfSmallCell(String text, {bool alignLeft = false}) {
//     return pw.Container(
//       height: 21,
//       alignment: alignLeft ? pw.Alignment.centerLeft : pw.Alignment.center,
//       padding: const pw.EdgeInsets.symmetric(horizontal: 5),
//       child: pw.Text(
//         text,
//         textAlign: alignLeft ? pw.TextAlign.left : pw.TextAlign.center,
//         style: const pw.TextStyle(fontSize: 7),
//       ),
//     );
//   }

//   pw.Widget _pdfSignatureRow() {
//     return pw.Row(
//       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//       children: [
//         pw.Text(
//           "Class Teacher's Sign",
//           style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.Text(
//           "Principal's Sign",
//           style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.Text(
//           "Parent's Sign",
//           style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
//         ),
//       ],
//     );
//   }

//   pw.Widget _pdfBottomNotes() {
//     return pw.Container(
//       width: double.infinity,
//       padding: const pw.EdgeInsets.only(top: 8),
//       decoration: const pw.BoxDecoration(
//         border: pw.Border(top: pw.BorderSide(color: PdfColors.black, width: 1)),
//       ),
//       child: pw.Column(
//         children: [
//           pw.Text(
//             'Activities Grade : A = Outstanding, B = Very Good, C = Good, D = Need Improvement',
//             textAlign: pw.TextAlign.center,
//             style: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold),
//           ),
//           pw.SizedBox(height: 7),
//           pw.Text(
//             'Mark Vs. Grade : A1=90-100, A2=80-89, B1=70-79, B2=60-69, C1=50-59, C2=40-49, D=33-39',
//             textAlign: pw.TextAlign.center,
//             style: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }

//   List<_ScholasticRow> _buildScholasticRows(List<dynamic> data) {
//     return List<_ScholasticRow>.generate(data.length, (index) {
//       final dynamic item = data[index];

//       final String subjectName = _safe(
//         _readValue(item, ['SubjectName', 'subjectName']),
//         'Subject ${index + 1}',
//       );

//       final double maxMark = _toDouble(
//         _readValue(item, ['TotalMarks', 'totalMarks', 'CE', 'ce']),
//         fallback: 0,
//       );

//       final double markScored = _toDouble(
//         _readValue(item, ['MarksObtained', 'marksObtained', 'TE', 'te']),
//         fallback: 0,
//       );

//       final double marksOutOf25 = maxMark > 0
//           ? (markScored / maxMark) * 25
//           : 0.0;

//       final double percentage = maxMark > 0
//           ? (markScored / maxMark) * 100
//           : 0.0;

//       final String apiGrade = _safe(_readValue(item, ['GRADE', 'grade']), '');

//       final String absent = _safe(_readValue(item, ['Absent', 'absent']), 'N');

//       final String grade = absent.toUpperCase() == 'Y'
//           ? 'AB'
//           : apiGrade.isNotEmpty
//           ? apiGrade
//           : _gradeFromPercentage(percentage);

//       return _ScholasticRow(
//         subject: subjectName,
//         maxMark: maxMark,
//         markScored: markScored,
//         marksOutOf25: marksOutOf25,
//         percentage: percentage,
//         grade: grade,
//       );
//     });
//   }

//   String _getStudentName(List<dynamic> data) {
//     if (data.isEmpty) {
//       return _safe(AppData.studentName, '');
//     }

//     final dynamic value = _readValue(data.first, ['Name', 'name']);

//     return _safe(value, _safe(AppData.studentName, ''));
//   }

//   String _getAdmissionNo(List<dynamic> data) {
//     if (data.isEmpty) {
//       return _safe(AppData.admissionNo, '');
//     }

//     final dynamic value = _readValue(data.first, ['Admno', 'admno']);

//     return _safe(value, _safe(AppData.admissionNo, ''));
//   }

//   String _getGender(List<dynamic> data) {
//     if (data.isEmpty) return '-';

//     final dynamic value = _readValue(data.first, ['Gender', 'gender']);

//     return _safe(value, '-');
//   }

//   String _getAbsentText(List<dynamic> data) {
//     final bool isAbsent = data.any((item) {
//       final String absent = _safe(_readValue(item, ['Absent', 'absent']), 'N');

//       return absent.toUpperCase() == 'Y';
//     });

//     return isAbsent ? 'Yes' : 'No';
//   }

//   String _getAttendanceStatus(List<dynamic> data) {
//     final bool isAbsent = data.any((item) {
//       final String absent = _safe(_readValue(item, ['Absent', 'absent']), 'N');

//       return absent.toUpperCase() == 'Y';
//     });

//     return isAbsent ? 'Absent' : 'Present';
//   }

//   dynamic _readValue(dynamic item, List<String> keys) {
//     if (item == null) return null;

//     if (item is Map) {
//       for (final String key in keys) {
//         if (item.containsKey(key)) {
//           return item[key];
//         }
//       }

//       for (final String key in keys) {
//         for (final dynamic entry in item.entries) {
//           if (entry.key.toString().toLowerCase() == key.toLowerCase()) {
//             return entry.value;
//           }
//         }
//       }

//       return null;
//     }

//     try {
//       final dynamic json = item.toJson();

//       if (json is Map) {
//         for (final String key in keys) {
//           if (json.containsKey(key)) {
//             return json[key];
//           }
//         }

//         for (final String key in keys) {
//           for (final dynamic entry in json.entries) {
//             if (entry.key.toString().toLowerCase() == key.toLowerCase()) {
//               return entry.value;
//             }
//           }
//         }
//       }
//     } catch (_) {}

//     for (final String key in keys) {
//       try {
//         switch (key) {
//           case 'SubjectName':
//             return item.SubjectName;
//           case 'subjectName':
//             return item.subjectName;

//           case 'TotalMarks':
//             return item.TotalMarks;
//           case 'totalMarks':
//             return item.totalMarks;

//           case 'MarksObtained':
//             return item.MarksObtained;
//           case 'marksObtained':
//             return item.marksObtained;

//           case 'CE':
//             return item.CE;
//           case 'ce':
//             return item.ce;

//           case 'TE':
//             return item.TE;
//           case 'te':
//             return item.te;

//           case 'GRADE':
//             return item.GRADE;
//           case 'grade':
//             return item.grade;

//           case 'Absent':
//             return item.Absent;
//           case 'absent':
//             return item.absent;

//           case 'Admno':
//             return item.Admno;
//           case 'admno':
//             return item.admno;

//           case 'Name':
//             return item.Name;
//           case 'name':
//             return item.name;

//           case 'Gender':
//             return item.Gender;
//           case 'gender':
//             return item.gender;
//         }
//       } catch (_) {}
//     }

//     return null;
//   }

//   String _branchValue(List<String> keys, {dynamic fallback = ''}) {
//     if (branchData == null) {
//       return _safe(fallback, '');
//     }

//     for (final String key in keys) {
//       if (branchData!.containsKey(key)) {
//         final String value = _safe(branchData![key], '');

//         if (value.isNotEmpty) {
//           return value;
//         }
//       }
//     }

//     for (final String key in keys) {
//       for (final MapEntry<String, dynamic> entry in branchData!.entries) {
//         if (entry.key.toLowerCase() == key.toLowerCase()) {
//           final String value = _safe(entry.value, '');

//           if (value.isNotEmpty) {
//             return value;
//           }
//         }
//       }
//     }

//     return _safe(fallback, '');
//   }

//   String _joinNonEmpty(List<String?> values, {String separator = ', '}) {
//     return values
//         .map((value) => value?.trim() ?? '')
//         .where((value) => value.isNotEmpty && value.toLowerCase() != 'null')
//         .join(separator);
//   }

//   double _toDouble(dynamic value, {double fallback = 0}) {
//     if (value == null) return fallback;

//     final String text = value.toString().trim();

//     if (text.isEmpty || text.toLowerCase() == 'null') {
//       return fallback;
//     }

//     return double.tryParse(text) ?? fallback;
//   }

//   String _safe(dynamic value, [String fallback = '-']) {
//     final String text = value?.toString().trim() ?? '';

//     if (text.isEmpty || text.toLowerCase() == 'null') {
//       return fallback;
//     }

//     return text;
//   }

//   String _formatNumber(double value) {
//     if (value % 1 == 0) {
//       return value.toInt().toString();
//     }

//     return value.toStringAsFixed(2);
//   }

//   String _gradeFromPercentage(double percentage) {
//     if (percentage >= 90) return 'A1';
//     if (percentage >= 80) return 'A2';
//     if (percentage >= 70) return 'B1';
//     if (percentage >= 60) return 'B2';
//     if (percentage >= 50) return 'C1';
//     if (percentage >= 40) return 'C2';
//     if (percentage >= 33) return 'D';
//     return 'E';
//   }
// }

// class _ScholasticRow {
//   final String subject;
//   final double maxMark;
//   final double markScored;
//   final double marksOutOf25;
//   final double percentage;
//   final String grade;

//   const _ScholasticRow({
//     required this.subject,
//     required this.maxMark,
//     required this.markScored,
//     required this.marksOutOf25,
//     required this.percentage,
//     required this.grade,
//   });
// }

// class _ActivityRow {
//   final String activity;
//   final String grade;

//   const _ActivityRow(this.activity, this.grade);
// }
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/marklist/domain/entities/fetch_marklist_entity.dart';
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

class _ExamMarkDetailsPageState extends State<ExamMarkDetailsPage> {
  String classAndDivision = '';
  Map<String, dynamic>? branchData;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final String? value = await SharedPreferenceHelper()
          .getClassAndDivision();

      final Map<String, dynamic>? savedBranchData =
          await SharedPreferenceHelper().getBranchData();

      if (!mounted) return;

      setState(() {
        classAndDivision = value ?? '';
        branchData = savedBranchData;
      });
      print("========== APP DATA ==========");
      print("AppData.accYear = '${AppData.accYear}'");
      print("AppData.studentStdId = ${AppData.studentStdId}");
      print("AppData.studentDivId = ${AppData.studentDivId}");
      print("AppData.admissionNo = ${AppData.admissionNo}");
      print("==============================");
      context.read<MarklistCubit>().fetchMarkList(
        FetchMarkListParameter(
          branchId: 1,
          accYear: AppData.accYear ?? '',
          standardId: AppData.studentStdId?.toString() ?? '',
          divisionId: AppData.studentDivId?.toString() ?? '',
          examTermId: widget.examTermId,
          admno: AppData.admissionNo?.toString() ?? '',
        ),
      );
    });
  }

  void _goBack() {
    final MarklistCubit marklistCubit = context.read<MarklistCubit>();

    Navigator.pop(context, true);

    marklistCubit.fetchExamTerms();
  }

  FetchMarkListDetails? _firstReport(List<FetchMarkListDetails>? data) {
    if (data == null || data.isEmpty) return null;
    return data.first;
  }

  Future<void> generateAndDownloadPdf() async {
    try {
      final currentState = context.read<MarklistCubit>().state;

      if (currentState is! MarkListLoaded) {
        _showMessage('No report data available to download.');
        return;
      }

      final FetchMarkListDetails? report = _firstReport(
        currentState.response.data,
      );

      if (report == null) {
        _showMessage('No report data available to download.');
        return;
      }

      final List<_ScholasticRow> rows = _buildScholasticRows(report);
      final _SummaryData summaryData = _buildSummaryData(report, rows);

      final pw.Document pdf = pw.Document();

      final pw.MemoryImage? logo = await _loadPdfLogo();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 24),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                _pdfSchoolHeader(logo),

                pw.SizedBox(height: 18),

                pw.Text(
                  'PROGRESS REPORT ${_safe(AppData.accYear)}',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 17,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.SizedBox(height: 10),

                pw.Center(
                  child: pw.Container(
                    width: 210,
                    height: 34,
                    alignment: pw.Alignment.center,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.red, width: 1.5),
                    ),
                    child: pw.Text(
                      widget.examTerm.toUpperCase(),
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 13,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                pw.SizedBox(height: 18),

                _pdfStudentDetails(report),

                pw.SizedBox(height: 14),

                _pdfSectionTitle('SCHOLASTIC AREA'),

                _pdfScholasticTable(rows),

                pw.SizedBox(height: 10),

                _pdfOverallSummary(summaryData),

                pw.SizedBox(height: 16),

                // _pdfActivitySection(
                //   title: 'Co-Scholastic Activities',
                //   secondTitle: widget.examTerm,
                //   rows: const [
                //     _ActivityRow('Extra Curricular Activity', 'A'),
                //     _ActivityRow('Home Work & Co-operations', 'B'),
                //     _ActivityRow('Neatness & Tidiness', 'A'),
                //   ],
                // ),

                // pw.SizedBox(height: 12),

                // _pdfActivitySection(
                //   title: 'Discipline',
                //   secondTitle: widget.examTerm,
                //   rows: const [_ActivityRow('Discipline & Moral Values', 'A')],
                // ),
                pw.Spacer(),

                _pdfSignatureRow(),

                pw.SizedBox(height: 14),

                _pdfBottomNotes(),

                pw.SizedBox(height: 8),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Generated by Cristal',
                      style: const pw.TextStyle(fontSize: 6),
                    ),
                    pw.Text(
                      'Page ${context.pageNumber}/${context.pagesCount}',
                      style: const pw.TextStyle(fontSize: 6),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );

      final String safeExamTerm = widget.examTerm
          .trim()
          .replaceAll(RegExp(r'[^A-Za-z0-9_ -]'), '')
          .replaceAll(' ', '_');

      final String fileName =
          'Progress_Report_${safeExamTerm}_${DateTime.now().millisecondsSinceEpoch}.pdf';

      final Directory tempDir = await getTemporaryDirectory();
      final File tempFile = File('${tempDir.path}/$fileName');

      await tempFile.writeAsBytes(await pdf.save());

      await MediaStore.ensureInitialized();

      MediaStore.appFolder = 'Cristal';

      final MediaStore mediaStore = MediaStore();

      final result = await mediaStore.saveFile(
        tempFilePath: tempFile.path,
        dirType: DirType.download,
        dirName: DirName.download,
      );

      if (!mounted) return;

      if (result != null) {
        _showMessage('PDF saved in Downloads/Cristal ✔');
      } else {
        throw Exception('Save failed');
      }
    } catch (e) {
      debugPrint('PDF ERROR: $e');

      if (!mounted) return;

      _showMessage('Failed to save PDF: $e');
    }
  }

  Future<pw.MemoryImage?> _loadPdfLogo() async {
    try {
      final String logoUrl = _safe(
        _branchValue(['Logo', 'logo'], fallback: AppData.logo),
        '',
      );

      if (logoUrl.isEmpty) return null;

      if (logoUrl.startsWith('http')) {
        final response = await http.get(Uri.parse(logoUrl));

        if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
          return pw.MemoryImage(response.bodyBytes);
        }

        return null;
      }

      final ByteData data = await rootBundle.load(logoUrl);
      return pw.MemoryImage(data.buffer.asUint8List());
    } catch (e) {
      debugPrint('LOGO LOAD ERROR: $e');
      return null;
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _goBack();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: _goBack,
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text(
            '${widget.examTerm} Progress Report',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              onPressed: generateAndDownloadPdf,
              icon: const Icon(Icons.download_rounded, color: Colors.black),
            ),
          ],
        ),
        body: BlocBuilder<MarklistCubit, MarklistState>(
          builder: (context, state) {
            if (state is MarkListLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MarkListError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }

            if (state is MarkListLoaded) {
              final FetchMarkListDetails? report = _firstReport(
                state.response.data,
              );

              if (report == null) {
                return const Center(
                  child: Text(
                    'No Data Found',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }

              return _buildMobileReportScreen(report);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildMobileReportScreen(FetchMarkListDetails report) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 24),
      child: _buildReportMobileUi(report),
    );
  }

  Widget _buildReportMobileUi(FetchMarkListDetails report) {
    final List<_ScholasticRow> rows = _buildScholasticRows(report);
    final _SummaryData summaryData = _buildSummaryData(report, rows);

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSchoolHeader(),

          const SizedBox(height: 16),

          Text(
            'PROGRESS REPORT ${_safe(AppData.accYear)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 10),

          Center(
            child: Container(
              width: 210,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1.5),
              ),
              child: Text(
                widget.examTerm.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          _buildStudentDetails(report),

          const SizedBox(height: 14),

          _sectionTitle('SCHOLASTIC AREA'),

          _buildScholasticTable(rows),

          const SizedBox(height: 10),

          _buildOverallSummary(summaryData),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSchoolHeader() {
    final String branchName = _safe(
      _branchValue([
        'BranchName',
        'branchName',
        'branch_name',
      ], fallback: AppData.branchName),
      '',
    );

    final String place = _safe(
      _branchValue(['Place', 'place'], fallback: AppData.place),
      '',
    );

    final String postPin = _branchValue([
      'Post_Pin',
      'post_Pin',
      'postPin',
      'PostPin',
      'post_pin',
      'PIN',
      'pin',
    ]);

    final String district = _branchValue(['District', 'district']);

    final String state = _branchValue(['State', 'state']);

    final String email = _branchValue(['Email', 'email']);

    final String phone = _branchValue([
      'Phone',
      'phone',
      'Phone1',
      'phone1',
      'Mobile',
      'mobile',
    ]);

    final String addressText = _joinNonEmpty([place, postPin, district, state]);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _logoBox(),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            children: [
              Text(
                branchName.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),

              if (addressText.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  addressText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 7.2,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ],

              if (email.isNotEmpty) ...[
                const SizedBox(height: 3),
                Text(
                  'Email: $email',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 7.2,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ],

              if (phone.isNotEmpty) ...[
                const SizedBox(height: 3),
                Text(
                  'Phone: $phone',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 7.2,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(width: 8),

        _logoBox(),
      ],
    );
  }

  Widget _logoBox() {
    final String logo = _safe(
      _branchValue(['Logo', 'logo'], fallback: AppData.logo),
      '',
    );

    return Container(
      width: 54,
      height: 54,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: ClipOval(
        child: logo.isNotEmpty
            ? Image.network(
                logo,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _logoFallback();
                },
              )
            : _logoFallback(),
      ),
    );
  }

  Widget _logoFallback() {
    return const Center(
      child: Text(
        'LOGO',
        style: TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildStudentDetails(FetchMarkListDetails report) {
    final StudentInfoEntity? student = report.studentInfo;

    final String studentName = _safe(
      student?.name,
      _safe(AppData.studentName, ''),
    );
    final String admissionNo = _safe(
      student?.admno,
      _safe(AppData.admissionNo, ''),
    );
    final String gender = _safe(student?.gender);
    final String dob = _formatDate(student?.dob);
    final String father = _safe(student?.father);
    final String mother = _safe(student?.mother);
    final String address = _safe(student?.address);
    final String mobile = _safe(student?.mobile);
    final String classText = _getClassText(student);
    final String absent = _formatNullableNumber(report.summary?.attendance);

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _detailLine("Student's Name", studentName)),
            const SizedBox(width: 8),
            Expanded(
              child: _detailLine('Adm No', admissionNo, valueBold: true),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(child: _detailLine('Class', classText)),
            const SizedBox(width: 8),
            Expanded(child: _detailLine('DOB', dob)),
          ],
        ),
        Row(
          children: [
            Expanded(child: _detailLine('Gender', gender)),
            const SizedBox(width: 8),
            Expanded(child: _detailLine('Absent', absent)),
          ],
        ),
        Row(
          children: [
            Expanded(child: _detailLine("Father's Name", father)),
            const SizedBox(width: 8),
            Expanded(child: _detailLine("Mother's Name", mother)),
          ],
        ),
        Row(
          children: [
            Expanded(child: _detailLine('Address', address)),
            const SizedBox(width: 8),
            Expanded(child: _detailLine('Mobile Number', mobile)),
          ],
        ),
      ],
    );
  }

  Widget _detailLine(String label, String value, {bool valueBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 74,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 7.4,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
          const Text(
            ':',
            style: TextStyle(
              fontSize: 7.4,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              value,
              maxLines: label == 'Address' ? 2 : 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: valueBold ? 15 : 7.8,
                fontWeight: valueBold ? FontWeight.w900 : FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildScholasticTable(List<_ScholasticRow> rows) {
    final double totalMaxMark = rows.fold<double>(
      0,
      (sum, row) => sum + row.maxMark,
    );

    final double totalMarkScored = rows.fold<double>(
      0,
      (sum, row) => sum + row.markScored,
    );

    final double totalOutOf25 = rows.fold<double>(
      0,
      (sum, row) => sum + row.marksOutOf25,
    );

    final double totalPercentage = totalMaxMark > 0
        ? (totalMarkScored / totalMaxMark) * 100
        : 0.0;

    final String totalGrade = rows.isEmpty
        ? '-'
        : _gradeFromPercentage(totalPercentage);

    return Table(
      border: TableBorder.all(color: Colors.black, width: 0.8),
      columnWidths: const {
        0: FlexColumnWidth(2.45),
        1: FlexColumnWidth(0.8),
        2: FlexColumnWidth(0.9),
        3: FlexColumnWidth(1.12),
        4: FlexColumnWidth(0.9),
        5: FlexColumnWidth(0.65),
      },
      children: [
        TableRow(
          children: [
            _tableHeader('Subject Name'),
            _tableHeader('Max. Mark'),
            _tableHeader('Mark Scored'),
            _tableHeader('Marks Out of 25'),
            _tableHeader('Percentage'),
            _tableHeader('Grade'),
          ],
        ),

        if (rows.isEmpty)
          TableRow(
            children: [
              _tableCell(
                'No subjects found',
                align: TextAlign.left,
                bold: true,
              ),
              _tableCell('-'),
              _tableCell('-'),
              _tableCell('-'),
              _tableCell('-'),
              _tableCell('-'),
            ],
          ),

        ...rows.map((row) {
          return TableRow(
            children: [
              _tableCell(row.subject, align: TextAlign.left, bold: true),
              _tableCell(_formatNumber(row.maxMark)),
              _tableCell(_formatNumber(row.markScored)),
              _tableCell(_formatNumber(row.marksOutOf25)),
              _tableCell(_formatNumber(row.percentage)),
              _tableCell(row.grade, bold: true),
            ],
          );
        }),

        TableRow(
          children: [
            _tableCell('Total', align: TextAlign.left, bold: true),
            _tableCell(
              rows.isEmpty ? '-' : _formatNumber(totalMaxMark),
              bold: true,
            ),
            _tableCell(
              rows.isEmpty ? '-' : _formatNumber(totalMarkScored),
              bold: true,
            ),
            _tableCell(
              rows.isEmpty ? '-' : _formatNumber(totalOutOf25),
              bold: true,
            ),
            _tableCell(
              rows.isEmpty ? '-' : _formatNumber(totalPercentage),
              bold: true,
            ),
            _tableCell(totalGrade, bold: true),
          ],
        ),
      ],
    );
  }

  Widget _tableHeader(String text) {
    return Container(
      height: 24,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 6.4,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _tableCell(
    String text, {
    TextAlign align = TextAlign.center,
    bool bold = false,
  }) {
    return Container(
      height: 24,
      alignment: align == TextAlign.left
          ? Alignment.centerLeft
          : Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Text(
        text,
        textAlign: align,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 6.7,
          fontWeight: bold ? FontWeight.w900 : FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildOverallSummary(_SummaryData summary) {
    return SizedBox(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _summaryPair(
              label: 'Overall Marks',
              value: summary.overallMarks,
              valueWidth: 78,
            ),
            const SizedBox(width: 8),
            _summaryPair(
              label: 'Percentage',
              value: summary.percentage,
              valueWidth: 54,
            ),
            const SizedBox(width: 8),
            _summaryPair(
              label: 'Attendance',
              value: summary.attendance,
              valueWidth: 54,
            ),
            const SizedBox(width: 8),
            _summaryPair(
              label: 'Overall Grade',
              value: summary.overallGrade,
              valueWidth: 48,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryPair({
    required String label,
    required String value,
    required double valueWidth,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _summaryLabel(label),
        const SizedBox(width: 4),
        _summaryValue(value, width: valueWidth),
      ],
    );
  }

  Widget _summaryLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 7,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
    );
  }

  Widget _summaryValue(String text, {required double width}) {
    return Container(
      width: width,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }

  pw.Widget _pdfSchoolHeader(pw.MemoryImage? logo) {
    final String branchName = _safe(
      _branchValue([
        'BranchName',
        'branchName',
        'branch_name',
      ], fallback: AppData.branchName),
      '',
    );

    final String place = _safe(
      _branchValue(['Place', 'place'], fallback: AppData.place),
      '',
    );

    final String postPin = _branchValue([
      'Post_Pin',
      'post_Pin',
      'postPin',
      'PostPin',
      'post_pin',
      'PIN',
      'pin',
    ]);

    final String district = _branchValue(['District', 'district']);

    final String state = _branchValue(['State', 'state']);

    final String email = _branchValue(['Email', 'email']);

    final String phone = _branchValue([
      'Phone',
      'phone',
      'Phone1',
      'phone1',
      'Mobile',
      'mobile',
    ]);

    final String addressText = _joinNonEmpty([place, postPin, district, state]);

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _pdfLogoBox(logo),

        pw.SizedBox(width: 8),

        pw.Expanded(
          child: pw.Column(
            children: [
              pw.Text(
                branchName.toUpperCase(),
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 15,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              if (addressText.isNotEmpty) ...[
                pw.SizedBox(height: 6),
                pw.Text(
                  addressText,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],

              if (email.isNotEmpty) ...[
                pw.SizedBox(height: 3),
                pw.Text(
                  'Email: $email',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],

              if (phone.isNotEmpty) ...[
                pw.SizedBox(height: 3),
                pw.Text(
                  'Phone: $phone',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),

        pw.SizedBox(width: 8),

        _pdfLogoBox(logo),
      ],
    );
  }

  pw.Widget _pdfLogoBox(pw.MemoryImage? logo) {
    return pw.Container(
      width: 54,
      height: 54,
      alignment: pw.Alignment.center,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        border: pw.Border.all(color: PdfColors.black, width: 1),
      ),
      child: logo != null
          ? pw.ClipOval(
              child: pw.Image(
                logo,
                width: 50,
                height: 50,
                fit: pw.BoxFit.cover,
              ),
            )
          : pw.Text(
              'LOGO',
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
            ),
    );
  }

  pw.Widget _pdfStudentDetails(FetchMarkListDetails report) {
    final StudentInfoEntity? student = report.studentInfo;

    final String studentName = _safe(
      student?.name,
      _safe(AppData.studentName, ''),
    );
    final String admissionNo = _safe(
      student?.admno,
      _safe(AppData.admissionNo, ''),
    );
    final String gender = _safe(student?.gender);
    final String dob = _formatDate(student?.dob);
    final String father = _safe(student?.father);
    final String mother = _safe(student?.mother);
    final String address = _safe(student?.address);
    final String mobile = _safe(student?.mobile);
    final String classText = _getClassText(student);
    final String absent = _formatNullableNumber(report.summary?.attendance);

    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Expanded(child: _pdfDetailLine("Student's Name", studentName)),
            pw.SizedBox(width: 8),
            pw.Expanded(
              child: _pdfDetailLine('Adm No', admissionNo, valueBold: true),
            ),
          ],
        ),
        pw.Row(
          children: [
            pw.Expanded(child: _pdfDetailLine('Class', classText)),
            pw.SizedBox(width: 8),
            pw.Expanded(child: _pdfDetailLine('DOB', dob)),
          ],
        ),
        pw.Row(
          children: [
            pw.Expanded(child: _pdfDetailLine('Gender', gender)),
            pw.SizedBox(width: 8),
            pw.Expanded(child: _pdfDetailLine('Absent', absent)),
          ],
        ),
        pw.Row(
          children: [
            pw.Expanded(child: _pdfDetailLine("Father's Name", father)),
            pw.SizedBox(width: 8),
            pw.Expanded(child: _pdfDetailLine("Mother's Name", mother)),
          ],
        ),
        pw.Row(
          children: [
            pw.Expanded(child: _pdfDetailLine('Address', address)),
            pw.SizedBox(width: 8),
            pw.Expanded(child: _pdfDetailLine('Phone No', mobile)),
          ],
        ),
      ],
    );
  }

  pw.Widget _pdfDetailLine(
    String label,
    String value, {
    bool valueBold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 74,
            child: pw.Text(
              label,
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Text(
            ':',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(width: 5),
          pw.Expanded(
            child: pw.Text(
              value,
              maxLines: label == 'Address' ? 2 : 1,
              style: pw.TextStyle(
                fontSize: valueBold ? 12 : 8,
                fontWeight: valueBold
                    ? pw.FontWeight.bold
                    : pw.FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _pdfSectionTitle(String title) {
    return pw.Container(
      height: 24,
      alignment: pw.Alignment.center,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 1),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  pw.Widget _pdfScholasticTable(List<_ScholasticRow> rows) {
    final double totalMaxMark = rows.fold<double>(
      0,
      (sum, row) => sum + row.maxMark,
    );

    final double totalMarkScored = rows.fold<double>(
      0,
      (sum, row) => sum + row.markScored,
    );

    final double totalOutOf25 = rows.fold<double>(
      0,
      (sum, row) => sum + row.marksOutOf25,
    );

    final double totalPercentage = totalMaxMark > 0
        ? (totalMarkScored / totalMaxMark) * 100
        : 0.0;

    final String totalGrade = rows.isEmpty
        ? '-'
        : _gradeFromPercentage(totalPercentage);

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black, width: 0.8),
      columnWidths: {
        0: const pw.FlexColumnWidth(2.45),
        1: const pw.FlexColumnWidth(0.8),
        2: const pw.FlexColumnWidth(0.9),
        3: const pw.FlexColumnWidth(1.12),
        4: const pw.FlexColumnWidth(0.9),
        5: const pw.FlexColumnWidth(0.65),
      },
      children: [
        pw.TableRow(
          children: [
            _pdfTableHeader('Subject Name'),
            _pdfTableHeader('Max. Mark'),
            _pdfTableHeader('Mark Scored'),
            _pdfTableHeader('Marks Out of 25'),
            _pdfTableHeader('Percentage'),
            _pdfTableHeader('Grade'),
          ],
        ),

        if (rows.isEmpty)
          pw.TableRow(
            children: [
              _pdfTableCell('No subjects found', alignLeft: true, bold: true),
              _pdfTableCell('-'),
              _pdfTableCell('-'),
              _pdfTableCell('-'),
              _pdfTableCell('-'),
              _pdfTableCell('-'),
            ],
          ),

        ...rows.map((row) {
          return pw.TableRow(
            children: [
              _pdfTableCell(row.subject, alignLeft: true, bold: true),
              _pdfTableCell(_formatNumber(row.maxMark)),
              _pdfTableCell(_formatNumber(row.markScored)),
              _pdfTableCell(_formatNumber(row.marksOutOf25)),
              _pdfTableCell(_formatNumber(row.percentage)),
              _pdfTableCell(row.grade, bold: true),
            ],
          );
        }),

        pw.TableRow(
          children: [
            _pdfTableCell('Total', alignLeft: true, bold: true),
            _pdfTableCell(
              rows.isEmpty ? '-' : _formatNumber(totalMaxMark),
              bold: true,
            ),
            _pdfTableCell(
              rows.isEmpty ? '-' : _formatNumber(totalMarkScored),
              bold: true,
            ),
            _pdfTableCell(
              rows.isEmpty ? '-' : _formatNumber(totalOutOf25),
              bold: true,
            ),
            _pdfTableCell(
              rows.isEmpty ? '-' : _formatNumber(totalPercentage),
              bold: true,
            ),
            _pdfTableCell(totalGrade, bold: true),
          ],
        ),
      ],
    );
  }

  pw.Widget _pdfTableHeader(String text) {
    return pw.Container(
      height: 24,
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.symmetric(horizontal: 2),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(fontSize: 6.6, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  pw.Widget _pdfTableCell(
    String text, {
    bool alignLeft = false,
    bool bold = false,
  }) {
    return pw.Container(
      height: 24,
      alignment: alignLeft ? pw.Alignment.centerLeft : pw.Alignment.center,
      padding: const pw.EdgeInsets.symmetric(horizontal: 3),
      child: pw.Text(
        text,
        textAlign: alignLeft ? pw.TextAlign.left : pw.TextAlign.center,
        maxLines: 1,
        style: pw.TextStyle(
          fontSize: 6.8,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  pw.Widget _pdfOverallSummary(_SummaryData summary) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        _pdfSummaryPair(
          label: 'Overall Marks',
          value: summary.overallMarks,
          valueWidth: 78,
        ),
        _pdfSummaryPair(
          label: 'Percentage',
          value: summary.percentage,
          valueWidth: 54,
        ),
        _pdfSummaryPair(
          label: 'Attendance',
          value: summary.attendance,
          valueWidth: 54,
        ),
        _pdfSummaryPair(
          label: 'Overall Grade',
          value: summary.overallGrade,
          valueWidth: 48,
        ),
      ],
    );
  }

  pw.Widget _pdfSummaryPair({
    required String label,
    required String value,
    required double valueWidth,
  }) {
    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(width: 4),
        pw.Container(
          width: valueWidth,
          height: 22,
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black, width: 1),
          ),
          child: pw.Text(
            value,
            style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // pw.Widget _pdfActivitySection({
  //   required String title,
  //   String secondTitle = '',
  //   required List<_ActivityRow> rows,
  // }) {
  //   return pw.Container(
  //     width: double.infinity,
  //     padding: const pw.EdgeInsets.fromLTRB(12, 8, 12, 10),
  //     decoration: pw.BoxDecoration(
  //       border: pw.Border.all(color: PdfColors.black, width: 1),
  //     ),
  //     child: pw.Column(
  //       children: [
  //         pw.Row(
  //           mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
  //           children: [
  //             pw.Text(
  //               title,
  //               style: pw.TextStyle(
  //                 fontSize: 8,
  //                 fontWeight: pw.FontWeight.bold,
  //               ),
  //             ),
  //             pw.Text(
  //               secondTitle,
  //               style: pw.TextStyle(
  //                 fontSize: 8,
  //                 fontWeight: pw.FontWeight.bold,
  //               ),
  //             ),
  //           ],
  //         ),
  //         pw.SizedBox(height: 8),
  //         pw.Row(
  //           children: [
  //             pw.Expanded(
  //               flex: 58,
  //               child: pw.Table(
  //                 border: pw.TableBorder.all(
  //                   color: PdfColors.black,
  //                   width: 0.8,
  //                 ),
  //                 children: [
  //                   pw.TableRow(children: [_pdfSmallHeader('Activities')]),
  //                   ...rows.map((row) {
  //                     return pw.TableRow(
  //                       children: [
  //                         _pdfSmallCell(row.activity, alignLeft: true),
  //                       ],
  //                     );
  //                   }),
  //                 ],
  //               ),
  //             ),
  //             pw.SizedBox(width: 20),
  //             pw.Expanded(
  //               flex: 36,
  //               child: pw.Table(
  //                 border: pw.TableBorder.all(
  //                   color: PdfColors.black,
  //                   width: 0.8,
  //                 ),
  //                 children: [
  //                   pw.TableRow(children: [_pdfSmallHeader('Grade')]),
  //                   ...rows.map((row) {
  //                     return pw.TableRow(children: [_pdfSmallCell(row.grade)]);
  //                   }),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  pw.Widget _pdfSmallHeader(String text) {
    return pw.Container(
      height: 21,
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.symmetric(horizontal: 4),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  pw.Widget _pdfSmallCell(String text, {bool alignLeft = false}) {
    return pw.Container(
      height: 21,
      alignment: alignLeft ? pw.Alignment.centerLeft : pw.Alignment.center,
      padding: const pw.EdgeInsets.symmetric(horizontal: 5),
      child: pw.Text(
        text,
        textAlign: alignLeft ? pw.TextAlign.left : pw.TextAlign.center,
        style: const pw.TextStyle(fontSize: 7),
      ),
    );
  }

  pw.Widget _pdfSignatureRow() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          "Class Teacher's Sign",
          style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          "Principal's Sign",
          style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          "Parent's Sign",
          style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  pw.Widget _pdfBottomNotes() {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.only(top: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: PdfColors.black, width: 1)),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'Activities Grade : A = Outstanding, B = Very Good, C = Good, D = Need Improvement',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 7),
          pw.Text(
            'Mark Vs. Grade : A1=90-100, A2=80-89, B1=70-79, B2=60-69, C1=50-59, C2=40-49, D=33-39',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );
  }

  List<_ScholasticRow> _buildScholasticRows(FetchMarkListDetails report) {
    final List<SubjectEntity> subjects = report.subjects ?? [];

    return List<_ScholasticRow>.generate(subjects.length, (index) {
      final SubjectEntity subject = subjects[index];

      final String subjectName = _safe(
        subject.subjectName,
        'Subject ${index + 1}',
      );

      final double maxMark = (subject.maxMark ?? 0).toDouble();

      final double markScored =
          (subject.marksObtained ?? ((subject.ce ?? 0) + (subject.te ?? 0)))
              .toDouble();

      final double marksOutOf25 =
          subject.markOutOf25 ??
          (maxMark > 0 ? (markScored / maxMark) * 25 : 0.0);

      final double percentage =
          subject.percentage ??
          (maxMark > 0 ? (markScored / maxMark) * 100 : 0.0);

      final String absent = _safe(subject.absent, 'N');

      final String apiGrade = _safe(subject.grade, '');

      final String grade = absent.toUpperCase() == 'Y'
          ? 'AB'
          : apiGrade.isNotEmpty
          ? apiGrade
          : _gradeFromPercentage(percentage);

      return _ScholasticRow(
        subject: subjectName,
        maxMark: maxMark,
        markScored: markScored,
        marksOutOf25: marksOutOf25,
        percentage: percentage,
        grade: grade,
      );
    });
  }

  _SummaryData _buildSummaryData(
    FetchMarkListDetails report,
    List<_ScholasticRow> rows,
  ) {
    final SummaryEntity? summary = report.summary;

    final double totalMaxMark = rows.fold<double>(
      0,
      (sum, row) => sum + row.maxMark,
    );

    final double totalMarkScored = rows.fold<double>(
      0,
      (sum, row) => sum + row.markScored,
    );

    final double calculatedPercentage = totalMaxMark > 0
        ? (totalMarkScored / totalMaxMark) * 100
        : 0.0;

    final String overallMarks =
        summary?.overallMarks != null && summary?.maximumMarks != null
        ? '${summary!.overallMarks} / ${summary.maximumMarks}'
        : summary?.overallMarks != null
        ? summary!.overallMarks.toString()
        : rows.isNotEmpty
        ? '${_formatNumber(totalMarkScored)} / ${_formatNumber(totalMaxMark)}'
        : '-';

    final String percentage = summary?.percentage != null
        ? _formatNumber(summary!.percentage!)
        : rows.isNotEmpty
        ? _formatNumber(calculatedPercentage)
        : '-';

    final String attendance = _formatNullableNumber(summary?.attendance);

    final String overallGrade = _safe(
      summary?.overallGrade,
      rows.isNotEmpty ? _gradeFromPercentage(calculatedPercentage) : '-',
    );

    return _SummaryData(
      overallMarks: overallMarks,
      percentage: percentage,
      attendance: attendance,
      overallGrade: overallGrade,
    );
  }

  String _getClassText(StudentInfoEntity? student) {
    final String standard = _safe(student?.standard, '');
    final String division = _safe(student?.division, '');

    final String apiClass = _joinNonEmpty([standard, division], separator: ' ');

    if (apiClass.isNotEmpty) return apiClass;

    return _safe(classAndDivision);
  }

  String _formatDate(String? value) {
    final String text = value?.trim() ?? '';

    if (text.isEmpty || text.toLowerCase() == 'null') {
      return '-';
    }

    final DateTime? date = DateTime.tryParse(text);

    if (date == null) {
      return text;
    }

    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();

    return '$day-$month-$year';
  }

  String _formatNullableNumber(num? value) {
    if (value == null) return '-';

    return _formatNumber(value.toDouble());
  }

  String _branchValue(List<String> keys, {dynamic fallback = ''}) {
    if (branchData == null) {
      return _safe(fallback, '');
    }

    for (final String key in keys) {
      if (branchData!.containsKey(key)) {
        final String value = _safe(branchData![key], '');

        if (value.isNotEmpty) {
          return value;
        }
      }
    }

    for (final String key in keys) {
      for (final MapEntry<String, dynamic> entry in branchData!.entries) {
        if (entry.key.toLowerCase() == key.toLowerCase()) {
          final String value = _safe(entry.value, '');

          if (value.isNotEmpty) {
            return value;
          }
        }
      }
    }

    return _safe(fallback, '');
  }

  String _joinNonEmpty(List<String?> values, {String separator = ', '}) {
    return values
        .map((value) => value?.trim() ?? '')
        .where((value) => value.isNotEmpty && value.toLowerCase() != 'null')
        .join(separator);
  }

  String _safe(dynamic value, [String fallback = '-']) {
    final String text = value?.toString().trim() ?? '';

    if (text.isEmpty || text.toLowerCase() == 'null') {
      return fallback;
    }

    return text;
  }

  String _formatNumber(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(2);
  }

  String _gradeFromPercentage(double percentage) {
    if (percentage >= 90) return 'A1';
    if (percentage >= 80) return 'A2';
    if (percentage >= 70) return 'B1';
    if (percentage >= 60) return 'B2';
    if (percentage >= 50) return 'C1';
    if (percentage >= 40) return 'C2';
    if (percentage >= 33) return 'D';
    return 'E';
  }
}

class _ScholasticRow {
  final String subject;
  final double maxMark;
  final double markScored;
  final double marksOutOf25;
  final double percentage;
  final String grade;

  const _ScholasticRow({
    required this.subject,
    required this.maxMark,
    required this.markScored,
    required this.marksOutOf25,
    required this.percentage,
    required this.grade,
  });
}

class _SummaryData {
  final String overallMarks;
  final String percentage;
  final String attendance;
  final String overallGrade;

  const _SummaryData({
    required this.overallMarks,
    required this.percentage,
    required this.attendance,
    required this.overallGrade,
  });
}

class _ActivityRow {
  final String activity;
  final String grade;

  const _ActivityRow(this.activity, this.grade);
}
