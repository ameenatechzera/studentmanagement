// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:studentmanagement/core/appdata/appdata.dart';

// // import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
// // import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';
// // import 'package:studentmanagement/fetaures/fees/presentation/unPaidFee/un_paid_fee_cubit.dart';
// // import 'package:studentmanagement/fetaures/fees/presentation/widgets/paidfee_widget.dart';
// // import 'package:studentmanagement/fetaures/fees/presentation/widgets/pendingfee_widget.dart';

// // import '../../domain/entities/accyearResult.dart';
// // import '../../domain/entities/unpaid fee_result.dart' as unpaid;

// // final TextEditingController accYearController = TextEditingController();

// // class FeesScreen extends StatefulWidget {
// //   const FeesScreen({super.key});

// //   @override
// //   State<FeesScreen> createState() => _FeesScreenState();
// // }

// // class _FeesScreenState extends State<FeesScreen> {
// //   final Set<int> _selectedIndexes = {};
// //   final Map<int, unpaid.Datum> _selectedFees = {};
// //   @override
// //   void initState() {
// //     context.read<FeesCubit>().fetchAccYearList();

// //     super.initState();
// //   }

// //   final List<Datum> accYears = [];
// //   String? _selectedAccYear;
// //   double get _selectedTotal {
// //     return _selectedFees.values.fold(0.0, (sum, fee) {
// //       return sum + _parseAmount(fee.totalBalance);
// //     });
// //   }

// //   double _parseAmount(String value) {
// //     final cleanedValue = value.replaceAll(RegExp(r'[^0-9.]'), '');
// //     return double.tryParse(cleanedValue) ?? 0.0;
// //   }

// //   void _onFeeSelectionChanged(int index, unpaid.Datum fee, bool isSelected) {
// //     setState(() {
// //       if (isSelected) {
// //         _selectedIndexes.add(index);
// //         _selectedFees[index] = fee;
// //       } else {
// //         _selectedIndexes.remove(index);
// //         _selectedFees.remove(index);
// //       }
// //     });
// //   }

// //   void _clearSelectedFees() {
// //     setState(() {
// //       _selectedIndexes.clear();
// //       _selectedFees.clear();
// //     });
// //   }

// //   void _onPayPressed() {
// //     final selectedFeeList = _selectedFees.values.toList();

// //     debugPrint('Selected fees count: ${selectedFeeList.length}');
// //     debugPrint('Selected total: $_selectedTotal');

// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(
// //           'Pay button clicked. Total: ${_selectedTotal.toStringAsFixed(2)}',
// //         ),
// //       ),
// //     );

// //     // TODO: Call payment API here.
// //     // You can pass selectedFeeList and _selectedTotal to your payment request.
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         title: const Text("Fees"),
// //         actions: [
// //           BlocConsumer<FeesCubit, FeesState>(
// //             listener: (context, state) {
// //               if (state is AccYearSuccess) {
// //                 accYears.clear();
// //                 accYears.addAll(state.accYearResult.data);
// //                 context.read<FeesCubit>().fetchPaidFeesDetails(
// //                   PaidFeesRequest(
// //                     accyear: AppData.accYear!,
// //                     admno: AppData.admissionNo!,
// //                   ),
// //                 );
// //                 context.read<UnPaidFeeCubit>().fetchUnPaidFeesDetails(
// //                   PaidFeesRequest(
// //                     accyear: AppData.accYear!,
// //                     admno: AppData.admissionNo!,
// //                   ),
// //                 );
// //               }
// //             },
// //             builder: (context, state) {
// //               if (accYears.isNotEmpty) {
// //                 return PopupMenuButton<String>(
// //                   icon: Row(
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: [
// //                       Text(
// //                         _selectedAccYear ?? accYears.first.accYear,
// //                         // ✅ uses state variable
// //                         style: const TextStyle(
// //                           fontSize: 13,
// //                           fontWeight: FontWeight.w600,
// //                           color: Colors.black,
// //                         ),
// //                       ),
// //                       const Icon(Icons.arrow_drop_down, color: Colors.black),
// //                     ],
// //                   ),
// //                   offset: const Offset(0, 50),
// //                   constraints: const BoxConstraints(
// //                     minWidth: 150,
// //                     maxWidth: 200,
// //                   ),
// //                   onSelected: (value) {
// //                     setState(() {
// //                       _selectedAccYear = value;
// //                       _selectedIndexes.clear();
// //                       _selectedFees.clear();
// //                     });

// //                     Future.microtask(() {
// //                       context.read<FeesCubit>().fetchPaidFeesDetails(
// //                         PaidFeesRequest(
// //                           accyear: value,
// //                           admno: AppData.admissionNo!,
// //                         ),
// //                       );
// //                       context.read<UnPaidFeeCubit>().fetchUnPaidFeesDetails(
// //                         PaidFeesRequest(
// //                           accyear: value,
// //                           admno: AppData.admissionNo!,
// //                         ),
// //                       );
// //                     });
// //                   },
// //                   itemBuilder: (context) {
// //                     return accYears.map((datum) {
// //                       return PopupMenuItem<String>(
// //                         value: datum.accYear,
// //                         child: Text(datum.accYear),
// //                       );
// //                     }).toList();
// //                   },
// //                 );
// //               }

// //               return const SizedBox();
// //             },
// //           ),
// //         ],
// //       ),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: EdgeInsets.only(bottom: _selectedFees.isNotEmpty ? 100 : 20),
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // ================= PENDING =================
// //                 const SizedBox(height: 8),
// //                 const Text(
// //                   'Pending',
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.red,
// //                     fontSize: 15,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 8),

// //                 BlocConsumer<UnPaidFeeCubit, UnPaidFeeState>(
// //                   listener: (context, state) {},
// //                   builder: (context, state) {
// //                     if (state is FeeUnpaidInitial) {
// //                       return const SizedBox(
// //                         width: 24,
// //                         height: 24,
// //                         child: CircularProgressIndicator(strokeWidth: 2),
// //                       );
// //                     }
// //                     if (state is FeesUnPaidSuccess) {
// //                       if (state.feeUnPaidResult.data.isNotEmpty) {
// //                         return PendingFee(
// //                           feesUnpaidList: state.feeUnPaidResult,
// //                           selectedIndexes: _selectedIndexes,
// //                           onSelectionChanged: _onFeeSelectionChanged,
// //                         );
// //                       } else {
// //                         return Container();
// //                       }
// //                     }
// //                     if (state is FeeUnPaidFailure) {
// //                       return Center(child: Text(state.error));
// //                     }
// //                     return Container();
// //                   },
// //                 ),

// //                 const SizedBox(height: 20),

// //                 // ================= PAID =================
// //                 const Text(
// //                   'Paid',
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.green,
// //                     fontSize: 15,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 BlocConsumer<FeesCubit, FeesState>(
// //                   listener: (context, state) {},
// //                   builder: (context, state) {
// //                     if (state is FeesInitial) {
// //                       return const SizedBox(
// //                         width: 24,
// //                         height: 24,
// //                         child: CircularProgressIndicator(strokeWidth: 2),
// //                       );
// //                     }
// //                     if (state is FeesPaidSuccess) {
// //                       return PaidFee(feePaidResult: state.feePaidResult);
// //                     } else {
// //                       return Container();
// //                     }
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //       bottomNavigationBar: _selectedFees.isNotEmpty
// //           ? SafeArea(
// //               child: Container(
// //                 padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black.withOpacity(0.08),
// //                       blurRadius: 12,
// //                       offset: const Offset(0, -4),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     Expanded(
// //                       child: Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             '${_selectedFees.length} fee selected',
// //                             style: const TextStyle(
// //                               fontSize: 13,
// //                               color: Colors.grey,
// //                               fontWeight: FontWeight.w500,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 4),
// //                           Text(
// //                             'Total: ${_selectedTotal.toStringAsFixed(2)}',
// //                             style: const TextStyle(
// //                               fontSize: 17,
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.black,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),

// //                     TextButton(
// //                       onPressed: _clearSelectedFees,
// //                       child: const Text(
// //                         'Clear',
// //                         style: TextStyle(
// //                           color: Colors.red,
// //                           fontWeight: FontWeight.w600,
// //                         ),
// //                       ),
// //                     ),

// //                     const SizedBox(width: 8),

// //                     ElevatedButton(
// //                       onPressed: _onPayPressed,
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: const Color(0xFF807FD8),
// //                         foregroundColor: Colors.white,
// //                         padding: const EdgeInsets.symmetric(
// //                           horizontal: 24,
// //                           vertical: 12,
// //                         ),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                       ),
// //                       child: const Text(
// //                         'Pay',
// //                         style: TextStyle(fontWeight: FontWeight.bold),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             )
// //           : null,
// //     );
// //   }
// // }

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

  final List<Datum> accYears = [];

  int _selectedTabIndex = 0;

  static const Color selectedTabPurple = Color(0xFF807FD8);
  static const Color unselectedTabColor = Color(0xFFF0EFFB);

  @override
  void initState() {
    super.initState();
    context.read<FeesCubit>().fetchAccYearList();
    context.read<UnPaidFeeCubit>().fetchUnPaidFeesDetails(
      PaidFeesRequest(accyear: AppData.accYear!, admno: AppData.admissionNo!),
    );

    context.read<FeesCubit>().fetchPaidFeesDetails(
      PaidFeesRequest(accyear: AppData.accYear!, admno: AppData.admissionNo!),
    );
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          _headerSection(),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: _selectedFees.isNotEmpty ? 100 : 20,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_selectedTabIndex == 0) ...[
                      const Text(
                        'Recently Pending',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      // const SizedBox(height: 10),
                      _pendingFeeSection(),
                    ],

                    if (_selectedTabIndex == 1) ...[_pendingFeeSection()],

                    if (_selectedTabIndex == 2) ...[_paidFeeSection()],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      //                 BlocConsumer<UnPaidFeeCubit, UnPaidFeeState>(
      //                   listener: (context, state) {},
      //                   builder: (context, state) {
      //                     if (state is FeeUnpaidInitial) {
      //                       return const Center(
      //                         child: Padding(
      //                           padding: EdgeInsets.all(24),
      //                           child: CircularProgressIndicator(
      //                             strokeWidth: 2,
      //                           ),
      //                         ),
      //                       );
      //                     }

      //                     if (state is FeesUnPaidSuccess) {
      //                       if (state.feeUnPaidResult.data.isNotEmpty) {
      //                         return PendingFee(
      //                           feesUnpaidList: state.feeUnPaidResult,
      //                           selectedIndexes: _selectedIndexes,
      //                           onSelectionChanged: _onFeeSelectionChanged,
      //                         );
      //                       } else {
      //                         return const SizedBox();
      //                       }
      //                     }

      //                     if (state is FeeUnPaidFailure) {
      //                       return Center(child: Text(state.error));
      //                     }

      //                     return const SizedBox();
      //                   },
      //                 ),
      //               ],

      //               // if (_selectedTabIndex == 0) const SizedBox(height: 20),

      //               // if (_selectedTabIndex == 0 || _selectedTabIndex == 2) ...[
      //               //   const Text(
      //               //     'Paid',
      //               //     style: TextStyle(
      //               //       fontWeight: FontWeight.bold,
      //               //       color: Colors.green,
      //               //       fontSize: 15,
      //               //     ),
      //               //   ),
      //               //   const SizedBox(height: 8),

      //               //   BlocConsumer<FeesCubit, FeesState>(
      //               //     listener: (context, state) {},
      //               //     builder: (context, state) {
      //               //       if (state is FeesInitial) {
      //               //         return const Center(
      //               //           child: Padding(
      //               //             padding: EdgeInsets.all(24),
      //               //             child: CircularProgressIndicator(
      //               //               strokeWidth: 2,
      //               //             ),
      //               //           ),
      //               //         );
      //               //       }

      //               //       if (state is FeesPaidSuccess) {
      //               //         return PaidFee(feePaidResult: state.feePaidResult);
      //               //       }

      //               //       return const SizedBox();
      //               //     },
      //               //   ),
      //               // ],
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: _selectedFees.isNotEmpty && _selectedTabIndex != 2
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
                        backgroundColor: selectedTabPurple,
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

  Widget _pendingFeeSection() {
    return BlocConsumer<UnPaidFeeCubit, UnPaidFeeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FeeUnpaidInitial) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
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
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: Text('No Pending List')),
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

  Widget _paidFeeSection() {
    return BlocConsumer<FeesCubit, FeesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FeesInitial) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        if (state is FeesPaidSuccess) {
          return PaidFee(feePaidResult: state.feePaidResult);
        }

        return const SizedBox();
      },
    );
  }

  Widget _headerSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: _selectedTabIndex == 0
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6E6CFF), Color(0xFFC4C3FF)],
              )
            : null,
        color: _selectedTabIndex == 0 ? null : Colors.white,

        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     Color(0xFF6E6CFF), // Top
        //     Color(0xFFC4C3FF), // Bottom
        //   ],
        // ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            12,
            20,
            _selectedTabIndex == 0 ? 18 : 14,
          ),
          child: Column(
            children: [
              _appBarDesign(),

              const SizedBox(height: 22),

              _tabBarDesign(),

              if (_selectedTabIndex == 0) ...[
                const SizedBox(height: 22),

                _summaryCard(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBarDesign() {
    final bool isOverall = _selectedTabIndex == 0;
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: isOverall ? Colors.white : Colors.black,
              size: 22,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              'Fees',
              style: TextStyle(
                color: isOverall ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // BlocConsumer<FeesCubit, FeesState>(
          //   listener: (context, state) {
          //     if (state is AccYearSuccess) {
          //       accYears.clear();
          //       accYears.addAll(state.accYearResult.data);

          //       _selectedAccYear ??= AppData.accYear ?? accYears.first.accYear;

          //       context.read<FeesCubit>().fetchPaidFeesDetails(
          //         PaidFeesRequest(
          //           accyear: _selectedAccYear!,
          //           admno: AppData.admissionNo!,
          //         ),
          //       );

          //       context.read<UnPaidFeeCubit>().fetchUnPaidFeesDetails(
          //         PaidFeesRequest(
          //           accyear: _selectedAccYear!,
          //           admno: AppData.admissionNo!,
          //         ),
          //       );
          //     }
          //   },
          //   builder: (context, state) {
          //     if (accYears.isEmpty) return const SizedBox();

          //     return PopupMenuButton<String>(
          //       color: Colors.white,
          //       offset: const Offset(0, 40),
          //       onSelected: _onAcademicYearSelected,
          //       itemBuilder: (context) {
          //         return accYears.map((datum) {
          //           return PopupMenuItem<String>(
          //             value: datum.accYear,
          //             child: Text(datum.accYear),
          //           );
          //         }).toList();
          //       },
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Text(
          //             _selectedAccYear ?? accYears.first.accYear,
          //             style: const TextStyle(
          //               fontSize: 12,
          //               fontWeight: FontWeight.w600,
          //               color: Colors.white,
          //             ),
          //           ),
          //           const Icon(
          //             Icons.arrow_drop_down,
          //             color: Colors.white,
          //             size: 20,
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _tabBarDesign() {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          _feeTabButton('Overall', 0),
          const SizedBox(width: 8),
          _feeTabButton('Pending', 1),
          const SizedBox(width: 8),
          _feeTabButton('Paid', 2),
        ],
      ),
    );
  }

  Widget _feeTabButton(String title, int index) {
    final bool isSelected = _selectedTabIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? selectedTabPurple : unselectedTabColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _summaryCard() {
    return BlocBuilder<FeesCubit, FeesState>(
      builder: (context, paidState) {
        double totalPaid = 0.0;

        if (paidState is FeesPaidSuccess) {
          totalPaid = paidState.feePaidResult.data.fold(0.0, (sum, fee) {
            return sum + _parseAmount(fee.totalPaidAmount);
          });
        }

        return BlocBuilder<UnPaidFeeCubit, UnPaidFeeState>(
          builder: (context, unpaidState) {
            double totalPending = 0.0;

            if (unpaidState is FeesUnPaidSuccess) {
              totalPending = unpaidState.feeUnPaidResult.data.fold(0.0, (
                sum,
                fee,
              ) {
                return sum + _parseAmount(fee.totalBalance);
              });
            }

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _summaryItem(
                      title: 'Total Paid',
                      subtitle: '(This Year)',
                      amount: _formatAmount(totalPaid),
                      // currency: 'AED',
                      color: Colors.green,
                    ),
                  ),

                  Container(width: 1, height: 82, color: Colors.grey.shade300),

                  Expanded(
                    child: _summaryItem(
                      title: 'Pending',
                      subtitle: '(This Year)',
                      amount: _formatAmount(totalPending),
                      // currency: 'AED',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _summaryItem({
    required String title,
    required String subtitle,
    required String amount,
    //required String currency,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 9,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          amount,
          style: TextStyle(
            fontSize: 25,
            color: color,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 5),
        // Text(
        //   currency,
        //   style: TextStyle(
        //     fontSize: 15,
        //     color: color,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
      ],
    );
  }

  String _formatAmount(double value) {
    if (value % 1 == 0) {
      return value.toStringAsFixed(0);
    }

    return value.toStringAsFixed(2);
  }
}
