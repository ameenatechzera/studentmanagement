import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/unpaid fee_result.dart';

class PendingFee extends StatelessWidget {
  UnpaidFeeResult feesUnpaidList;
  final Map<int, Set<int>> selectedDetails; // feeIndex -> selected detail indices
  final bool feeCollectionStatus;
  final void Function(int feeIndex, int? detailIndex, Datum fee, bool isSelected)
  onSelectionChanged;

  PendingFee({
    super.key,
    required this.feesUnpaidList,
    required this.selectedDetails,
    required this.onSelectionChanged,
    required this.feeCollectionStatus,
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

          dueDateStatus = dueDate.isBefore(todayOnly);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: _ExpandableFeeCard(
              index: index,
              fee: fee,
              formatedDate: formatedDate,
              dueDateStatus: dueDateStatus,
              selectedDetailIndexes: selectedDetails[index] ?? const <int>{},
              onSelectionChanged: onSelectionChanged,
              feeCollectionStatus: feeCollectionStatus,
            ),
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
  final Set<int> selectedDetailIndexes; // which lines in THIS card are selected
  final bool feeCollectionStatus;
  final void Function(int feeIndex, int? detailIndex, Datum fee, bool isSelected)
  onSelectionChanged;

  const _ExpandableFeeCard({
    required this.index,
    required this.fee,
    required this.formatedDate,
    required this.dueDateStatus,
    required this.selectedDetailIndexes,
    required this.onSelectionChanged,
    required this.feeCollectionStatus,
  });

  @override
  State<_ExpandableFeeCard> createState() => _ExpandableFeeCardState();
}

bool dueDateStatus = false;

class _ExpandableFeeCardState extends State<_ExpandableFeeCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final totalDetails = widget.fee.details.length;
    final selectedCount = widget.selectedDetailIndexes.length;
    final isFullySelected = totalDetails > 0 && selectedCount == totalDetails;
    final isPartiallySelected = selectedCount > 0 && selectedCount < totalDetails;
    final hasAnySelection = selectedCount > 0;

    return Container(
      decoration: BoxDecoration(
        color: hasAnySelection ? const Color(0xFFF3F0FF) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasAnySelection
              ? const Color(0xFF807FD8)
              : const Color(0xFFE8EAF1),
          width: hasAnySelection ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 6),
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
                      if (widget.feeCollectionStatus)
                        Checkbox(
                          tristate: true,
                          // true = all selected, null = some selected, false = none
                          value: isFullySelected
                              ? true
                              : (isPartiallySelected ? null : false),
                          activeColor: const Color(0xFF807FD8),
                          onChanged: (value) {
                            // Tapping toggles between "select all" and "clear all",
                            // regardless of whether it was fully or partially checked.
                            final selectAll = !isFullySelected;
                            widget.onSelectionChanged(
                              widget.index,
                              null, // null => whole-card toggle
                              widget.fee,
                              selectAll,
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
                            Text(
                              widget.fee.feeMonth,
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: constraints.maxWidth,
                                  ),
                                  child: Container(
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 2),
                                          child: Icon(
                                            Icons.calendar_today_outlined,
                                            size: 12,
                                            color: Colors.red,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Flexible(
                                          child: Text(
                                            'Last Date On ${widget.formatedDate}',
                                            softWrap: true,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      /// TOTAL BALANCE + EXPAND ICON
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 62,
                          maxWidth: 82,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.fee.totalBalance,
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const SizedBox(height: 4),
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
                    children: widget.fee.details.asMap().entries.map((entry) {
                      final detailIndex = entry.key;
                      final detail = entry.value;
                      final isLineSelected =
                      widget.selectedDetailIndexes.contains(detailIndex);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center, // was .start
                          children: [
                            /// LEDGER NAME
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center, // was .start
                                children: [
                                  if (widget.feeCollectionStatus)
                                    SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: Checkbox(
                                        value: isLineSelected,
                                        activeColor: const Color(0xFF807FD8),
                                        materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                        onChanged: (value) {
                                          widget.onSelectionChanged(
                                            widget.index,
                                            detailIndex,
                                            widget.fee,
                                            value ?? false,
                                          );
                                        },
                                      ),
                                    ),
                                  if (widget.feeCollectionStatus) const SizedBox(width: 8),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    // no more manual top margin needed now that everything centers
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF807FD8),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      detail.ledgerName,
                                      softWrap: true,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// AMOUNT
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 50,
                                maxWidth: 90,
                              ),
                              child: Text(
                                detail.amount,
                                softWrap: true,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
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