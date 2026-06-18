import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:studentmanagement/fetaures/fees/presentation/unPaidFee/un_paid_fee_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/pendingfee_skeleton.dart';

import '../../domain/entities/unpaid fee_result.dart';

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
          if(feesUnpaidList.length>0){
            return ListView.builder(
              itemCount: feesUnpaidList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final fee = feesUnpaidList[index];
                String formatedDate = fee.dueDate ?? '';
                try {
                  formatedDate = DateFormat('dd-MM-yyyy')
                      .format(DateTime.parse(fee.dueDate ?? ''));
                } catch (_) {}

                return _ExpandableFeeCard(
                  fee: fee,
                  formatedDate: formatedDate,
                );
              },
            );
          }
          else{
            return Container(
              child: Text('No Pending List'),
            );
          }

        }

        if (state is FeeUnPaidFailure) {
          return Center(child: Text(state.error));
        }

        return const SizedBox();
      },
    );
  }
}
class _ExpandableFeeCard extends StatefulWidget {
  final Datum fee;
  final String formatedDate;

  const _ExpandableFeeCard({
    required this.fee,
    required this.formatedDate,
  });

  @override
  State<_ExpandableFeeCard> createState() => _ExpandableFeeCardState();
}

class _ExpandableFeeCardState extends State<_ExpandableFeeCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
            /// LEFT BORDER
            Positioned(
              left: 0,
              top: 15,
              bottom: 15,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF807FD8),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            /// MAIN CONTENT
            Column(
              children: [
                /// HEADER ROW (tap to expand)
                InkWell(
                  onTap: () => setState(() => _isExpanded = !_isExpanded),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
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
                              /// FEE MONTH
                              Text(
                                widget.fee.feeMonth,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              /// DUE DATE
                              Text(
                                widget.formatedDate,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// TOTAL BALANCE + EXPAND ICON
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.fee.totalBalance,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Icon(
                              _isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: const Color(0xFF807FD8),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                /// EXPANDED DETAILS
                if (_isExpanded) ...[
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Column(
                      children: widget.fee.details.map((detail) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// LEDGER NAME
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF807FD8),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    detail.ledgerName,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),

                              /// AMOUNT
                              Text(
                                detail.amount,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF807FD8),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}