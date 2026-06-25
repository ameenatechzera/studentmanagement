import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';

import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/unPaidFee/un_paid_fee_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/paidfee_widget.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/pendingfee_widget.dart';

import '../../domain/entities/accyearResult.dart';
import '../../domain/entities/unpaid fee_result.dart' as unpaid;

final TextEditingController accYearController = TextEditingController();

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  final Set<int> _selectedIndexes = {};
  final Map<int, unpaid.Datum> _selectedFees = {};
  @override
  void initState() {
    context.read<FeesCubit>().fetchAccYearList();

    super.initState();
  }

  final List<Datum> accYears = [];
  String? _selectedAccYear;
  double get _selectedTotal {
    return _selectedFees.values.fold(0.0, (sum, fee) {
      return sum + _parseAmount(fee.totalBalance);
    });
  }

  double _parseAmount(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleanedValue) ?? 0.0;
  }

  void _onFeeSelectionChanged(int index, unpaid.Datum fee, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedIndexes.add(index);
        _selectedFees[index] = fee;
      } else {
        _selectedIndexes.remove(index);
        _selectedFees.remove(index);
      }
    });
  }

  void _clearSelectedFees() {
    setState(() {
      _selectedIndexes.clear();
      _selectedFees.clear();
    });
  }

  void _onPayPressed() {
    final selectedFeeList = _selectedFees.values.toList();

    debugPrint('Selected fees count: ${selectedFeeList.length}');
    debugPrint('Selected total: $_selectedTotal');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pay button clicked. Total: ${_selectedTotal.toStringAsFixed(2)}',
        ),
      ),
    );

    // TODO: Call payment API here.
    // You can pass selectedFeeList and _selectedTotal to your payment request.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Fees"),
        actions: [
          BlocConsumer<FeesCubit, FeesState>(
            listener: (context, state) {
              if (state is AccYearSuccess) {
                accYears.clear();
                accYears.addAll(state.accYearResult.data);
                context.read<FeesCubit>().fetchPaidFeesDetails(
                  PaidFeesRequest(
                    accyear: AppData.accYear!,
                    admno: AppData.admissionNo!,
                  ),
                );
                context.read<UnPaidFeeCubit>().fetchUnPaidFeesDetails(
                  PaidFeesRequest(
                    accyear: AppData.accYear!,
                    admno: AppData.admissionNo!,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (accYears.isNotEmpty) {
                return PopupMenuButton<String>(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedAccYear ?? accYears.first.accYear,
                        // ✅ uses state variable
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                  offset: const Offset(0, 50),
                  constraints: const BoxConstraints(
                    minWidth: 150,
                    maxWidth: 200,
                  ),
                  onSelected: (value) {
                    setState(() {
                      _selectedAccYear = value;
                      _selectedIndexes.clear();
                      _selectedFees.clear();
                    });

                    Future.microtask(() {
                      context.read<FeesCubit>().fetchPaidFeesDetails(
                        PaidFeesRequest(
                          accyear: value,
                          admno: AppData.admissionNo!,
                        ),
                      );
                      context.read<UnPaidFeeCubit>().fetchUnPaidFeesDetails(
                        PaidFeesRequest(
                          accyear: value,
                          admno: AppData.admissionNo!,
                        ),
                      );
                    });
                  },
                  itemBuilder: (context) {
                    return accYears.map((datum) {
                      return PopupMenuItem<String>(
                        value: datum.accYear,
                        child: Text(datum.accYear),
                      );
                    }).toList();
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: _selectedFees.isNotEmpty ? 100 : 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= PENDING =================
                const SizedBox(height: 8),
                const Text(
                  'Pending',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),

                BlocConsumer<UnPaidFeeCubit, UnPaidFeeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is FeeUnpaidInitial) {
                      return const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }
                    if (state is FeesUnPaidSuccess) {
                      if (state.feeUnPaidResult.data.isNotEmpty) {
                        return PendingFee(
                          feesUnpaidList: state.feeUnPaidResult,
                          selectedIndexes: _selectedIndexes,
                          onSelectionChanged: _onFeeSelectionChanged,
                        );
                      } else {
                        return Container();
                      }
                    }
                    if (state is FeeUnPaidFailure) {
                      return Center(child: Text(state.error));
                    }
                    return Container();
                  },
                ),

                const SizedBox(height: 20),

                // ================= PAID =================
                const Text(
                  'Paid',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                BlocConsumer<FeesCubit, FeesState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is FeesInitial) {
                      return const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }
                    if (state is FeesPaidSuccess) {
                      return PaidFee(feePaidResult: state.feePaidResult);
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _selectedFees.isNotEmpty
          ? SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_selectedFees.length} fee selected',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Total: ${_selectedTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    TextButton(
                      onPressed: _clearSelectedFees,
                      child: const Text(
                        'Clear',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    ElevatedButton(
                      onPressed: _onPayPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF807FD8),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Pay',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
