import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/amount_column.dart';

class PaidFee extends StatefulWidget {
  const PaidFee({super.key});

  @override
  State<PaidFee> createState() => _PaidFeeState();
}
int? expandedIndex; // 👈 add this in your StatefulWidget
class _PaidFeeState extends State<PaidFee> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeesCubit, FeesState>(
      builder: (context, state) {
        if (state is FeesInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FeesPaidSuccess) {
          final feesList = state.feePaidResult.data; // your API list


          return ListView.builder(
            itemCount: feesList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final fee = feesList[index];

              String formatedDate = fee.date!;
              try {
                formatedDate =formatDate(fee.date!);
              }catch(_){

              }
              final isExpanded = expandedIndex == index;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    expandedIndex = isExpanded ? null : index;
                  });
                },
                child: Container(
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
                            height: 42,
                            width: 42,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD81B60),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(width: 8),

                          // 🧾 CENTER - Receipt + Tick
                          Expanded(
                            child: Row(
                              children: [
                                const Text(
                                  '# Receipt No : ',
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
                            formatedDate ?? "",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      /// PAYMENT MODE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text("Pay Mode  "),
                              Text(
                                fee.paymentMode,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
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

                        ],
                      ),
                      /// 🔥 Arrow
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.money),
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
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          ),
                        ],
                      ),


                      /// 🔥 SHOW DETAILS ONLY WHEN EXPANDED
                      if (isExpanded) ...[
                        const SizedBox(height: 1),
                        const Divider(),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sl No'),
                              Text('Month'),
                              Text('Ledger'),
                              Text('Paid Amt'),
                            ],
                          ),
                        ),

                        ListView.builder(
                          itemCount: fee.details.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            final dtls = fee.details[i];
                            int srlNo = i+1;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 1),
                              padding: const EdgeInsets.all(1),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AmountColumn(
                                    title: "",
                                    value: srlNo.toString(),
                                  ),
                                  AmountColumn(
                                    title: "",
                                    value: dtls.feeMonth,
                                  ),
                                  AmountColumn(
                                    title: "",
                                    value: dtls.ledgerName,
                                  ),
                                  AmountColumn(
                                    title: "",
                                    value: dtls.paidAmount.toString(),
                                    valueColor: Colors.red,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        }

        if (state is FeesPaidFailure) {
          return Center(child: Text(state.error));
        }

        return const SizedBox();
      },
    );
  }
  String formatDate(String inputDate) {
    DateTime date = DateTime.parse(inputDate);
    return DateFormat('dd-MM-yyyy').format(date);
  }
}
