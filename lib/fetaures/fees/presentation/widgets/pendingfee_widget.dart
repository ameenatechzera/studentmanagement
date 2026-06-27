import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/unpaid fee_result.dart';

class PendingFee extends StatelessWidget {
  UnpaidFeeResult feesUnpaidList;
  final Set<int> selectedIndexes;
  final void Function(int index, Datum fee, bool isSelected) onSelectionChanged;
  PendingFee({
    super.key,
    required this.feesUnpaidList,
    required this.selectedIndexes,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (feesUnpaidList.data.length > 0) {
      return ListView.builder(
        itemCount: feesUnpaidList.data.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final fee = feesUnpaidList.data[index];
          String formatedDate = fee.dueDate ?? '';
          try {
            formatedDate = DateFormat(
              'dd-MM-yyyy',
            ).format(DateTime.parse(fee.dueDate ?? ''));
          } catch (_) {}

          final DateTime dueDate = DateFormat('dd-MM-yyyy').parse(formatedDate);
          final DateTime todayOnly = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          );

          if (dueDate.isBefore(todayOnly)) {
            dueDateStatus = true;
            print('dueDateStatus $dueDateStatus');
          } else {
            dueDateStatus = false;
          }
          print('dueDateStatusElse $dueDateStatus');
          return _ExpandableFeeCard(
            index: index,
            fee: fee,
            formatedDate: formatedDate,
            dueDateStatus: dueDateStatus,
            isSelected: selectedIndexes.contains(index),
            onSelectionChanged: onSelectionChanged,
          );
        },
      );
    } else {
      return Container(child: Text('No Pending List'));
    }
  }
}

class _ExpandableFeeCard extends StatefulWidget {
  final int index;
  final Datum fee;
  final String formatedDate;
  final bool dueDateStatus;
  final bool isSelected;
  final void Function(int index, Datum fee, bool isSelected) onSelectionChanged;

  const _ExpandableFeeCard({
    required this.index,
    required this.fee,
    required this.formatedDate,
    required this.dueDateStatus,
    required this.isSelected,
    required this.onSelectionChanged,
  });

  @override
  State<_ExpandableFeeCard> createState() => _ExpandableFeeCardState();
}

bool dueDateStatus = false;

class _ExpandableFeeCardState extends State<_ExpandableFeeCard> {
  bool _isExpanded = false;
  //bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isSelected ? const Color(0xFFF3F2FF) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: widget.isSelected
            ? Border.all(color: const Color(0xFF807FD8), width: 1)
            : null,
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
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: widget.isSelected,
                        activeColor: const Color(0xFF807FD8),
                        onChanged: (value) {
                          widget.onSelectionChanged(
                            widget.index,
                            widget.fee,
                            value ?? false,
                          );
                        },
                      ),

                      /// ICON
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
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

                            const SizedBox(height: 10),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/Group (5).svg',
                                  // width: 10,
                                  // height: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Pending Fee',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEAEA),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 12,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Last Date On ${widget.formatedDate}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // /// DUE DATE
                            // if (dueDateStatus)
                            //   Text(
                            //     widget.formatedDate,
                            //     style: const TextStyle(
                            //       fontSize: 13,
                            //       color: Colors.red,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                          ],
                        ),
                      ),

                      /// TOTAL BALANCE + EXPAND ICON
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Text(
                          //   widget.fee.totalBalance,
                          //   style: const TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                          // Icon(
                          //   _isExpanded
                          //       ? Icons.keyboard_arrow_up
                          //       : Icons.keyboard_arrow_down,
                          //   color: const Color(0xFF807FD8),
                          // ),
                          //const SizedBox(height: 4),
                          Text(
                            widget.fee.totalBalance,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),

                          SizedBox(
                            height: 34,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Pay action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF807FD8),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Pay',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Icon(
                          //   _isExpanded
                          //       ? Icons.keyboard_arrow_up
                          //       : Icons.keyboard_arrow_down,
                          //   color: const Color(0xFF807FD8),
                          // ),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Icon(
                                _isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: const Color(0xFF807FD8),
                              ),
                            ),
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
                                color: Colors.red,
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
    );
  }
}
