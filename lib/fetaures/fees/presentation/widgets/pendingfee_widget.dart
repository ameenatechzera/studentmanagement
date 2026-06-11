import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studentmanagement/fetaures/fees/presentation/unPaidFee/un_paid_fee_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/pendingfee_skeleton.dart';

class PendingFee extends StatelessWidget {
  const PendingFee({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnPaidFeeCubit, UnPaidFeeState>(
      builder: (context, state) {
        if (state is FeeUnpaidInitial || state is FeeUnpaidLoading) {
          return const PendingFeeShimmer();
        }

        if (state is FeesUnPaidSuccess) {
          final feesUnpaidList = state.feeUnPaidResult.data;

          return ListView.builder(
            itemCount: feesUnpaidList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final fee = feesUnpaidList[index];

              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 15,
                        bottom: 15,
                        child: Container(
                          width: 4,
                          // height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF807FD8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),

                      /// 🔹 MAIN CONTENT
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Row(
                          children: [
                            /// ICON
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

                            const SizedBox(width: 16),

                            /// TEXT SECTION
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// MONTH
                                  Text(
                                    fee.feeMonth,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  /// LEDGER NAME
                                  Text(
                                    fee.ledgerName,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  /// RED TEXT (like Due Date)
                                  Text(
                                    fee.dueDate,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// AMOUNT
                            Text(
                              fee.amount,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        if (state is FeeUnPaidFailure) {
          return Center(child: Text(state.error));
        }

        return const SizedBox();
      },
    );
  }
}
