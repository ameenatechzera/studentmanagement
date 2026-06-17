import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/amount_column.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:studentmanagement/fetaures/fees/presentation/widgets/pendingfee_skeleton.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

class PaidFee extends StatefulWidget {
  const PaidFee({super.key});

  @override
  State<PaidFee> createState() => _PaidFeeState();
}

int? expandedIndex;

class _PaidFeeState extends State<PaidFee> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeesCubit, FeesState>(
      builder: (context, state) {
        if (state is FeesInitial) {
          return const PendingFeeShimmer();
        }

        if (state is FeesPaidSuccess) {
          final feesList = state.feePaidResult.data; // your API list
          if(feesList.length>0){
            return ListView.builder(
              itemCount: feesList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final fee = feesList[index];

                String formatedDate = fee.date!;
                try {
                  formatedDate = formatDate(fee.date!);
                } catch (_) {}
                final isExpanded = expandedIndex == index;

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      expandedIndex = isExpanded ? null : index;
                    });
                  },
                  child: Container(
                    //margin: const EdgeInsets.only(bottom: 12),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// 🔹 HEADER
                              Row(
                                children: [
                                  // 🔵 LEFT - Circle Avatar
                                  Container(
                                    height: 44,
                                    width: 44,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF807FD8),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        'assets/icons/Group (1).svg',
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  // 🧾 CENTER - Receipt + Tick
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Receipt No : ',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          fee.receiptNo,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // 📅 RIGHT - Date
                                  Text(
                                    formatedDate,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await generateAndDownloadPdf(fee, context);
                                    },
                                    icon: Icon(Icons.download),
                                  ),
                                ],
                              ),

                              /// PAYMENT MODE
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 52),

                                  Row(
                                    children: [
                                      const Text("Payment Mode : "),
                                      Text(
                                        fee.paymentMode,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10.0,
                                          ),
                                          child: Row(
                                            children: [
                                              // Icon(Icons.money),
                                              Text(
                                                fee.totalPaidAmount,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                            ],
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(right: 10.0),
                                        //   child: Icon(
                                        //     isExpanded
                                        //         ? Icons.keyboard_arrow_up
                                        //         : Icons.keyboard_arrow_down,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // Text(
                              //   fee.totalPaidAmount,
                              //   style: const TextStyle(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              //   ],
                              // ),
                              if (isExpanded) ...[
                                const SizedBox(height: 1),
                                const Divider(),
                                const SizedBox(height: 12),

                                Table(
                                  border: TableBorder(
                                    verticalInside: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                  columnWidths: const {
                                    0: FlexColumnWidth(),
                                    1: FlexColumnWidth(),
                                    2: FlexColumnWidth(),
                                  },
                                  children: [
                                    /// HEADER
                                    const TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: Text(
                                            'Month',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: Text(
                                            'Ledger',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: Text(
                                            'Paid Amt',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),

                                    /// DATA (ONLY LOOP HERE)
                                    ...fee.details.map((dtls) {
                                      return TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              dtls.feeMonth,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              dtls.ledgerName,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              dtls.paidAmount.toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: 4,
                            child: Align(
                              alignment: isExpanded
                                  ? Alignment.center
                                  : Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: isExpanded ? 0 : 16,
                                ),
                                child: Container(
                                  height: 70,
                                  width: 4,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF807FD8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   left: 0,
                        //   top: isExpanded ? null : 16,
                        //   bottom: isExpanded ? null : null,
                        //   child: isExpanded
                        //       ? Center(
                        //           child: Padding(
                        //             padding: const EdgeInsets.symmetric(
                        //               vertical: 50,
                        //             ),
                        //             child: Container(
                        //               height: 70,
                        //               width: 4,
                        //               decoration: BoxDecoration(
                        //                 color: const Color(0xFF807FD8),
                        //                 borderRadius: BorderRadius.circular(10),
                        //               ),
                        //             ),
                        //           ),
                        //         )
                        //       : Container(
                        //           height: 70,
                        //           width: 4,
                        //           decoration: BoxDecoration(
                        //             color: const Color(0xFF807FD8),
                        //             borderRadius: BorderRadius.circular(10),
                        //           ),
                        //         ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          else{
            return Container(
              child: Text('No Paid List'),
            );
          }

        }

        if (state is FeesPaidFailure) {
          return Center(child: Text(state.error));
        }

        return const SizedBox();
      },
    );
  }

  Future<void> generateAndDownloadPdf(fee, BuildContext context) async {
    try {
      final pdf = pw.Document();

      pw.MemoryImage? logo;
      try {
        final logoUrl = AppData.logo;

        print('LOGO URL: $logoUrl');

        if (logoUrl != null && logoUrl.isNotEmpty) {
          final response = await http.get(Uri.parse(logoUrl));

          print('STATUS: ${response.statusCode}');

          if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
            logo = pw.MemoryImage(response.bodyBytes);
          }
        }
      } catch (e) {
        print('LOGO ERROR: $e');
        logo = null;
      }
      final branchData = await SharedPreferenceHelper().getBranchData();
      print('FULL BRANCH DATA: $branchData');
      final receiptNo = fee.receiptNo.toString();
      final paymentMode = fee.paymentMode.toString();
      final totalAmount = fee.totalPaidAmount.toString();
      final amount = double.tryParse(totalAmount) ?? 0;
      final words = NumberToWord()
          .convert('en-in', amount.toInt())
          .toUpperCase();
      final phone = branchData?['Phone1'] ?? '';
      final email = branchData?['Email'] ?? '';
      String receiptDate = fee.date.toString();
      try {
        receiptDate = DateFormat(
          'dd-MMM-yyyy',
        ).format(DateTime.parse(fee.date.toString()));
      } catch (_) {}

      // final nowText = DateFormat('d/M/yy, h:mm a').format(DateTime.now());

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 36, vertical: 28),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      receiptDate,
                      style: const pw.TextStyle(fontSize: 7),
                    ),
                    pw.Text(
                      'Fee Receipt - $receiptNo',
                      style: pw.TextStyle(
                        fontSize: 7,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 24),

                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Container(
                      width: 55,
                      height: 55,
                      child: logo != null
                          ? pw.Image(logo)
                          : pw.Container(
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.grey),
                              ),
                              child: pw.Center(
                                child: pw.Text(
                                  'LOGO',
                                  style: const pw.TextStyle(fontSize: 8),
                                ),
                              ),
                            ),
                    ),
                    pw.SizedBox(width: 35),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            AppData.branchName ?? '',
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            AppData.place ?? '',
                            style: const pw.TextStyle(fontSize: 8),
                          ),
                          pw.Text(
                            'Phone: $phone | Email: $email',
                            style: const pw.TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 8),
                pw.Divider(thickness: 0.6),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Receipt No: $receiptNo',
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.red,
                      ),
                    ),
                    pw.Text(
                      receiptDate,
                      style: const pw.TextStyle(fontSize: 8),
                    ),
                  ],
                ),

                pw.SizedBox(height: 14),

                pw.Center(
                  child: pw.Text(
                    'FEE RECEIPT',
                    style: pw.TextStyle(
                      fontSize: 11,
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline,
                    ),
                  ),
                ),

                pw.SizedBox(height: 12),

                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          _detailRow('Name', '${AppData.studentName}'),
                          _detailRow('Class', '${AppData.studentClass}'),
                          _detailRow('Cash/Bank', paymentMode),
                        ],
                      ),
                    ),
                    pw.SizedBox(width: 70),
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          _detailRow('AdmNo', '${AppData.admissionNo}'),
                          _detailRow('AccYear', '${AppData.accYear}'),
                          // _detailRow('Cash/Bank', paymentMode),
                        ],
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 10),

                pw.Table(
                  border: pw.TableBorder.all(
                    color: PdfColors.grey600,
                    width: 0.5,
                  ),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(40),
                    1: const pw.FixedColumnWidth(120),
                    2: const pw.FlexColumnWidth(),
                    3: const pw.FixedColumnWidth(75),
                    4: const pw.FixedColumnWidth(75),
                  },
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey200,
                      ),
                      children: [
                        _tableHeader('SL'),
                        _tableHeader('Month/Term'),
                        _tableHeader('Fee Head'),
                        _tableHeader('Due Amount'),
                        _tableHeader('Paid Amount'),
                      ],
                    ),
                    ...List.generate(fee.details.length, (index) {
                      final d = fee.details[index];

                      return pw.TableRow(
                        children: [
                          _tableCell('${index + 1}', alignCenter: true),
                          _tableCell(d.feeMonth.toString()),
                          _tableCell(d.ledgerName.toString()),
                          _tableCell(d.paidAmount.toString(), alignRight: true),
                          _tableCell(d.paidAmount.toString(), alignRight: true),
                        ],
                      );
                    }),
                    pw.TableRow(
                      children: [
                        _tableCell(''),
                        _tableCell(''),
                        _tableCell('Total', bold: true, alignRight: true),
                        _tableCell(totalAmount, bold: true, alignRight: true),
                        _tableCell(totalAmount, bold: true, alignRight: true),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 14),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _amountRow('Total Amount', totalAmount),
                        pw.SizedBox(height: 6),
                        _amountRow('Paid Amount', totalAmount),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 12),

                pw.RichText(
                  text: pw.TextSpan(
                    children: [
                      const pw.TextSpan(text: 'Amount in words:  '),
                      pw.TextSpan(
                        text: 'SAR $words ONLY',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 8),

                pw.Text(
                  'Narration: 2 Uniforms',
                  style: const pw.TextStyle(fontSize: 8),
                ),

                pw.SizedBox(height: 25),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'Prepared By: Admin',
                      style: const pw.TextStyle(fontSize: 8),
                    ),
                    pw.Column(
                      children: [
                        pw.Text(
                          'for, ${AppData.branchName}',
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                        pw.SizedBox(height: 28),
                        pw.Container(
                          width: 90,
                          height: 0.6,
                          color: PdfColors.black,
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Authorised Signatory',
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ],
                ),

                pw.Spacer(),

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

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/Fee Receipt - $receiptNo.pdf');

      await tempFile.writeAsBytes(await pdf.save());

      await MediaStore.ensureInitialized();
      MediaStore.appFolder = 'Cristal';

      final mediaStore = MediaStore();

      final result = await mediaStore.saveFile(
        tempFilePath: tempFile.path,
        dirType: DirType.download,
        dirName: DirName.download,
      );

      if (!mounted) return;

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF saved in Downloads ✔'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Save failed');
      }
    } catch (e) {
      debugPrint('PDF ERROR: $e');

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save PDF: $e')));
    }
  }

  pw.Widget _detailRow(String title, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 5),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 65,
            child: pw.Text(
              title,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Text(':  $value'),
        ],
      ),
    );
  }

  pw.Widget _tableHeader(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      child: pw.Center(
        child: pw.Text(
          text,
          style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
        ),
      ),
    );
  }

  pw.Widget _tableCell(
    String text, {
    bool bold = false,
    bool alignRight = false,
    bool alignCenter = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      child: pw.Align(
        alignment: alignCenter
            ? pw.Alignment.center
            : alignRight
            ? pw.Alignment.centerRight
            : pw.Alignment.centerLeft,
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: 8,
            fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ),
    );
  }

  pw.Widget _amountRow(String title, String value) {
    return pw.Row(
      children: [
        pw.SizedBox(
          width: 90,
          child: pw.Text('$title :', style: const pw.TextStyle(fontSize: 8)),
        ),
        pw.SizedBox(
          width: 60,
          child: pw.Text(
            value,
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          ),
        ),
      ],
    );
  }

  String formatDate(String inputDate) {
    DateTime date = DateTime.parse(inputDate);
    return DateFormat('dd-MM-yyyy').format(date);
  }
}
