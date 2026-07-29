import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/feePayExistRequest.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/offlinePaymentSaveRequest.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paymentSaveRequest.dart';
import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/unPaidFee/un_paid_fee_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/paidfee_widget.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/pendingfee_widget.dart';
import 'package:studentmanagement/services/easebuzz_service.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';
import '../../domain/entities/accyearResult.dart';
import '../../domain/entities/unpaid fee_result.dart' as unpaid;

final TextEditingController accYearController = TextEditingController();

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  // feeIndex -> set of selected detail indices within that fee card
  final Map<int, Set<int>> _selectedDetails = {};

  // Cache of the last successfully loaded unpaid fee list, so we can look up
  // Datum/detail objects by index from callbacks and payload builders without
  // needing to read bloc state again.
  List<unpaid.Datum> _unpaidFeesCache = [];

  // NEW: composite keys "<feeMonthId>_<ledgerId>" for ledger lines that are
  // already under fee-payment processing and must be blocked from selection.
  Set<String> _processingKeys = {};
  bool _isProcessingLoading = true;

  final List<Datum> accYears = [];

  int _selectedTabIndex = 0;
  String? _selectedAccYear;
  bool _isAccYearLoading = true;
  bool _isPendingLoading = true;
  bool _isPaidLoading = true;
  static const Color selectedTabPurple = Color(0xFF807FD8);
  static const Color unselectedTabColor = Color(0xFFF0EFFB);
  double totalPaid = 0.0;
  double totalPending = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<FeesCubit>().fetchAccYearList();
    });
  }

  void _fetchFeesForYear(String accYear) {
    setState(() {
      _isProcessingLoading = true;
    });

    context.read<FeesCubit>().fetchPaidFeesDetails(
      PaidFeesRequest(accyear: accYear, admno: AppData.admissionNo!),
    );

    context.read<UnPaidFeeCubit>().fetchUnPaidFeesDetails(
      PaidFeesRequest(accyear: accYear, admno: AppData.admissionNo!),
    );

    // NEW: fetch ledgers already under fee-payment processing for this year
    context.read<FeesCubit>().fetchProcessingFeeDetails(
      PaidFeesRequest(accyear: accYear, admno: AppData.admissionNo!),
    );
  }

  // NEW: build "<feeMonthId>_<ledgerId>" keys from the processing result and
  // drop any current selections that just became blocked.
  void _applyProcessingResult(dynamic feeProcessingResult) {
    final Set<String> keys = {};
    for (final datum in feeProcessingResult.data) {
      for (final feemonth in datum.feemonths) {
        for (final detail in feemonth.details) {
          keys.add('${feemonth.feemonthId}_${detail.ledgerId}');
        }
      }
    }

    _processingKeys = keys;

    _selectedDetails.forEach((feeIndex, detailIndexes) {
      if (feeIndex >= _unpaidFeesCache.length) return;
      final fee = _unpaidFeesCache[feeIndex];
      detailIndexes.removeWhere((detailIndex) {
        if (detailIndex >= fee.details.length) return false;
        final key = '${fee.feeMonthId}_${fee.details[detailIndex].ledgerId}';
        return _processingKeys.contains(key);
      });
    });
    _selectedDetails.removeWhere((_, set) => set.isEmpty);
  }

  Future<void> _handleFeesState(BuildContext context, FeesState state) async {
    if (!mounted) return;

    if (state is AccYearsInitial) {
      setState(() {
        _isAccYearLoading = true;
        _isPendingLoading = true;
        _isPaidLoading = true;
      });
      return;
    }

    if (state is AccYearSuccess) {
      AppData.schoolName = (await SharedPreferenceHelper().getSchoolName())!;
      final years = state.accYearResult.data;

      setState(() {
        accYears
          ..clear()
          ..addAll(years);

        _isAccYearLoading = false;

        if (accYears.isEmpty) {
          _selectedAccYear = null;
          _isPendingLoading = false;
          _isPaidLoading = false;
          _isProcessingLoading = false;
        } else {
          final appYear = AppData.accYear;
          final hasAppYear =
              appYear != null &&
                  accYears.any((item) => item.accYear == appYear);

          _selectedAccYear = hasAppYear ? appYear : accYears.first.accYear;

          _isPendingLoading = true;
          _isPaidLoading = true;
        }
      });

      if (_selectedAccYear != null) {
        _fetchFeesForYear(_selectedAccYear!);
      }
      return;
    }

    if (state is AccYearFailure) {
      setState(() {
        _isAccYearLoading = false;
        _isPendingLoading = false;
        _isPaidLoading = false;
        _isProcessingLoading = false;
      });
      return;
    }

    if (state is FeesInitial) {
      if (!_isPaidLoading) {
        setState(() {
          _isPaidLoading = true;
        });
      }
      return;
    }

    if (state is FeesPaidSuccess) {
      if (_isPaidLoading) {
        setState(() {
          _isPaidLoading = false;
        });
      }
      return;
    }

    if (state is FeesPaidFailure) {
      setState(() {
        _isPaidLoading = false;

        if (_isAccYearLoading) {
          _isAccYearLoading = false;
          _isPendingLoading = false;
        }
      });
      return;
    }

    // NEW: ledgers-under-processing result
    if (state is FeeProcessingFeeSuccess) {
      print('FeeProcessingFeeSuccess ${state.feeProcessingFeeResult.data}');
      setState(() {
        _applyProcessingResult(state.feeProcessingFeeResult);
        _isProcessingLoading = false;
      });
      return;
    }

    if (state is FeeProcessingFeeListFailure) {
      setState(() {
        _isProcessingLoading = false;
      });
      return;
    }
  }

  void _handleUnpaidState(BuildContext context, UnPaidFeeState state) {
    if (!mounted) return;

    if (state is FeeUnpaidInitial || state is FeeUnpaid_Loading) {
      if (!_isPendingLoading) {
        setState(() {
          _isPendingLoading = true;
        });
      }
      return;
    }

    if (state is FeesUnPaidSuccess) {
      // Refresh the cache whenever a new unpaid list arrives, and drop any
      // stale selections that no longer correspond to valid indices
      // (e.g. after switching academic year).
      setState(() {
        _unpaidFeesCache = state.feeUnPaidResult.data;
        _selectedDetails.removeWhere(
              (feeIndex, _) => feeIndex >= _unpaidFeesCache.length,
        );
        _isPendingLoading = false;
      });
      return;
    }

    if (state is FeeUnPaidFailure) {
      if (_isPendingLoading) {
        setState(() {
          _isPendingLoading = false;
        });
      }
    }
  }

  Widget _sectionLoader() {
    return const SizedBox(
      width: double.infinity,
      height: 140,
      child: Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: selectedTabPurple,
          ),
        ),
      ),
    );
  }

  double get _selectedTotal {
    double total = 0.0;
    _selectedDetails.forEach((feeIndex, detailIndexes) {
      if (feeIndex >= _unpaidFeesCache.length) return;
      final fee = _unpaidFeesCache[feeIndex];
      for (final detailIndex in detailIndexes) {
        if (detailIndex >= fee.details.length) continue;
        final rawAmount = fee.details[detailIndex].amount;
        final parsed = _parseAmount(rawAmount);
        debugPrint(
          'feeIndex=$feeIndex detailIndex=$detailIndex rawAmount="$rawAmount" parsed=$parsed',
        );
        total += parsed;
      }
    });
    debugPrint('selectedTotal=$total');
    return total;
  }

  int get _selectedFeeCardCount => _selectedDetails.length;

  double _parseAmount(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleanedValue) ?? 0.0;
  }

  // NEW: is this fee-month/ledger pair already under payment processing?
  bool _isLedgerProcessing(dynamic feeMonthId, dynamic ledgerId) {
    return _processingKeys.contains('${feeMonthId}_$ledgerId');
  }

  void _onFeeSelectionChanged(
      int feeIndex,
      int? detailIndex,
      unpaid.Datum fee,
      bool isSelected,
      ) {
    setState(() {
      final currentSet = _selectedDetails.putIfAbsent(feeIndex, () => <int>{});

      if (detailIndex == null) {
        // header checkbox -> select/clear every SELECTABLE line in this card
        if (isSelected) {
          currentSet
            ..clear()
            ..addAll(
              List.generate(fee.details.length, (i) => i).where(
                    (i) => !_isLedgerProcessing(
                  fee.feeMonthId,
                  fee.details[i].ledgerId,
                ),
              ),
            );
        } else {
          currentSet.clear();
        }
      } else {
        // Safety net: never let a processing ledger get selected, even if
        // called directly and bypassing the disabled checkbox.
        if (isSelected &&
            _isLedgerProcessing(fee.feeMonthId, fee.details[detailIndex].ledgerId)) {
          return;
        }

        if (isSelected) {
          currentSet.add(detailIndex);
        } else {
          currentSet.remove(detailIndex);
        }
      }

      if (currentSet.isEmpty) {
        _selectedDetails.remove(feeIndex);
      }
    });
  }

  void _clearSelectedFees() {
    setState(() {
      _selectedDetails.clear();
    });
  }

  void _onPayPressed(String trxnId, String response, String payStatus) {
    // Build a flat list of (fee, detail) pairs for everything currently selected
    final selectedPairs = <MapEntry<unpaid.Datum, unpaid.Detail>>[];
    _selectedDetails.forEach((feeIndex, detailIndexes) {
      if (feeIndex >= _unpaidFeesCache.length) return;
      final fee = _unpaidFeesCache[feeIndex];
      for (final detailIndex in detailIndexes) {
        if (detailIndex >= fee.details.length) continue;
        selectedPairs.add(MapEntry(fee, fee.details[detailIndex]));
      }
    });

    if (AppData.appType == 'Offline') {
      List<OfflineDetail> saveOfflineDetails = selectedPairs.map((entry) {
        final fee = entry.key;
        final detail = entry.value;
        return OfflineDetail(
          feemonthid: fee.feeMonthId.toString(),
          feemonth: fee.feeMonth,
          ledgerid: detail.ledgerId,
          ledgername: detail.ledgerName,
          dueamount: detail.amount,
          paidamount: detail.amount,
          // dueamount: "0.10",
          // paidamount: "0.10",
        );
      }).toList();

      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      print('formattedDate $formattedDate');
      context.read<FeesCubit>().saveOfflineFeeDetails(
        OfflineFeePayRequest(
          admno: AppData.admissionNo!,
          accyear: AppData.accYear!,
          date: formattedDate,
          totalamount: _selectedTotal.toStringAsFixed(2),
          paidamount: _selectedTotal.toStringAsFixed(2),
          // totalamount: "0.10",
          // paidamount: "0.10",
          transactionid: trxnId,
          status: payStatus,
          response: response,
          details: saveOfflineDetails,
          admissionId: AppData.admissionId!,
        ),
      );
    } else {
      List<saveFeeDetails> saveDetails = selectedPairs.map((entry) {
        final fee = entry.key;
        final detail = entry.value;
        return saveFeeDetails(
          feeMonthId: fee.feeMonth,
          ledgerId: "12",
          dueAmount: int.tryParse(fee.totalBalance) ?? 0,
          paidAmount: int.tryParse(detail.amount) ?? 0,
          paidStatus: false,
          chequeNo: null,
          chequeDate: fee.dueDate,
          userId: "",
          feeAmount: int.tryParse(detail.amount) ?? 0,
          taxId: "",
          taxType: "",
          taxAmount: 0,
          floodCess: 0,
        );
      }).toList();

      print('saveDetails ${saveDetails.toString()}');

      debugPrint('Selected detail lines count: ${selectedPairs.length}');
      debugPrint('Selected total: $_selectedTotal');
      context.read<FeesCubit>().saveFeeDetails(
        FeeSaveRequest(
          voucherNo: 0,
          invoiceNo: 0,
          suffixPrefixId: '',
          date: '',
          admno: AppData.admissionNo!,
          accYear: AppData.accYear!,
          ledgerId: 0,
          totalAmount: _selectedTotal,
          paidAmount: _selectedTotal,
          balance: 0,
          discount: 0,
          totalTax: 0,
          totalFloodCess: 0,
          status: true,
          narration: '',
          financialYearId: '',
          canceled: false,
          branchId: AppData.branchId!,
          voucherType: "Fee Collection",
          yearId: '',
          createdUser: '',
          details: saveDetails,
        ),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pay button clicked. Total: ${_selectedTotal.toStringAsFixed(2)}',
        ),
      ),
    );
  }

  static MethodChannel _channel = MethodChannel('easebuzz');
  bool _isPayLoading = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FeesCubit, FeesState>(listener: _handleFeesState),
        BlocListener<UnPaidFeeCubit, UnPaidFeeState>(
          listener: _handleUnpaidState,
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F5FF),
        body: Column(
          children: [
            _headerSection(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: _selectedDetails.isNotEmpty ? 100 : 20,
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
                        const SizedBox(height: 10),
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
        bottomNavigationBar:
        _selectedDetails.isNotEmpty && _selectedTabIndex != 2
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
                        '$_selectedFeeCardCount fee selected',
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
                BlocConsumer<FeesCubit, FeesState>(
                  listener: (context, state) async {
                    if (state is FeeSaveCheckLoading) {
                      // checkFeeExist just started — loader already shown via onPressed,
                      // this just keeps it in sync in case the state stream starts here.
                      if (!_isPayLoading) {
                        setState(() => _isPayLoading = true);
                      }
                      return;
                    }

                    if (state is FeeCheckFailure) {
                      setState(() => _isPayLoading = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                      return;
                    }

                    if (state is CheckFeeStatusSuccess) {
                      print('CheckFeeStatusSuccess ${state.response.status}');

                      if (state.response.status == false) {
                        setState(() => _isPayLoading = false);

                        final failedEntries = state.response.data
                            .where((d) => d.status == false)
                            .toList();

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Payment Issue"),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Top-level message, shown because top-level status is false
                                        Text(state.response.message),
                                        const SizedBox(height: 12),
                                        // Ledger info from data items whose own status is also false
                                        ...failedEntries.map(
                                              (d) => Padding(
                                            padding: const EdgeInsets.only(bottom: 8.0),
                                            child: Text(
                                              "Ledger: ${d.ledgerName ?? '-'}\nPaid Amount: ${d.paidAmount}",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // print('emailId ${AppData.emailId}');
                        String st_txnId = 'TXN${DateTime.now().millisecondsSinceEpoch}';
                        print('Schoolcode ${AppData.schoolCode}');

                        final easebuzz = EasebuzzService();
                        try {
                          final result = await easebuzz.getAccessKey(
                            txnid: st_txnId,
                            amount: _selectedTotal.toStringAsFixed(2),
                            //amount: '0.10',
                            productinfo: 'School Fee Payment',
                            firstname: 'cristal',
                            email: (AppData.emailId?.trim().isNotEmpty ?? false)
                                ? AppData.emailId!
                                : 'haristechzera@gmail.com',
                            phone: AppData.mobileNo!,
                            surl: 'https://techzera.in/',
                            furl: 'https://techzera.in/',
                            admissionNo: AppData.admissionNo!,
                            std: AppData.studentClass!,
                            div: AppData.studentDivId!,
                            studName: AppData.studentName!,
                            schoolName: AppData.schoolName!,
                          );

                          if (result.success) {
                            print('Access key: ${result.accessKey}');
                            String access_key = result.accessKey.toString();
                            String pay_mode = "production";
                            Object parameters = {
                              "access_key": access_key,
                              "pay_mode": pay_mode,
                            };

                            final payment_response = await _channel.invokeMethod(
                              "payWithEasebuzz",
                              parameters,
                            );
                            print('payment_response $payment_response');

                            // invokeMethod usually returns a Map<Object?, Object?> from platform channels,
                            // so cast it safely first
                            final Map<dynamic, dynamic> responseMap =
                            payment_response is Map ? payment_response : {};
                            print('responseMap ${responseMap['result']?.toString()}');

                            if (responseMap['result']?.toString().trim() != 'user_cancelled') {
                              _onPayPressed(
                                st_txnId,
                                payment_response.toString(),
                                responseMap['result']?.toString().trim() ?? '',
                              );
                              // NOTE: loader stays true here — _onPayPressed triggers
                              // saveFeeDetails/saveOfflineFeeDetails, and the loader is
                              // cleared below once FeeSave_Success or SaveFees_Failure fires.
                            } else {
                              // user cancelled — stop the loader, nothing more happening
                              setState(() => _isPayLoading = false);
                            }
                          } else {
                            print('Failed_case');
                            setState(() => _isPayLoading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${result.errorDesc}')),
                            );
                            print('Error: ${result.errorDesc}');
                          }
                        } catch (e) {
                          setState(() => _isPayLoading = false);
                          print('Request error: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Payment error: $e')),
                          );
                        }
                      }
                    }

                    if (state is FeeSave_Success) {
                      setState(() => _isPayLoading = false);
                      Navigator.pop(context);
                    }

                    if (state is SaveFees_Failure) {
                      setState(() => _isPayLoading = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: _isPayLoading
                          ? null // disabled while a payment flow is already running
                          : () async {
                        setState(() => _isPayLoading = true);

                        final feemonthPayload = _buildFeemonthPayload();

                        context.read<FeesCubit>().checkFeeExist(
                          FeePaymentExistRequest(
                            admno: AppData.admissionNo!,
                            accyear: AppData.accYear!,
                            feemonths: feemonthPayload,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedTabPurple,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: selectedTabPurple.withOpacity(0.6),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isPayLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                          : const Text(
                        'Pay',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )
            : null,
      ),
    );
  }

  List<Feemonth> _buildFeemonthPayload() {
    final List<Feemonth> payload = [];

    _selectedDetails.forEach((feeIndex, detailIndexes) {
      if (feeIndex >= _unpaidFeesCache.length) return;
      final fee = _unpaidFeesCache[feeIndex];

      final List<Ledger> ledgers = [];
      for (final detailIndex in detailIndexes) {
        if (detailIndex >= fee.details.length) continue;
        final detail = fee.details[detailIndex];
        print('detail ${detail.toJson()}');
        ledgers.add(
          Ledger(
            ledgerid: detail.ledgerId, // see note below
            // paidamount: detail.amount.toString() ?? "",
            paidamount: "1" ?? "",
          ),
        );
      }

      if (ledgers.isNotEmpty) {
        payload.add(Feemonth(feemonthid: fee.feeMonthId, ledgers: ledgers));
      }
    });

    return payload;
  }

  Widget _pendingFeeSection() {
    return BlocConsumer<UnPaidFeeCubit, UnPaidFeeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (_isAccYearLoading || _isPendingLoading || _isProcessingLoading) {
          return _sectionLoader();
        }

        if (state is FeesUnPaidSuccess) {
          print('wwwwwwwwwwwwwwww${AppData.feeCollectionStatus}');

          if (state.feeUnPaidResult.data.isNotEmpty) {
            return PendingFee(
              feesUnpaidList: state.feeUnPaidResult,
              selectedDetails: _selectedDetails,
              onSelectionChanged: _onFeeSelectionChanged,
              feeCollectionStatus: AppData.feeCollectionStatus,
              processingKeys: _processingKeys, // NEW
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
        if (_isAccYearLoading || _isPaidLoading) {
          return _sectionLoader();
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
          BlocConsumer<FeesCubit, FeesState>(
            listener: (context, state) {
              if (state is AccYearSuccess) {
                accYears.clear();
                accYears.addAll(state.accYearResult.data);
                print('AppData.accYear ${AppData.accYear}');

                _selectedAccYear ??= AppData.accYear ?? accYears.first.accYear;

                context.read<FeesCubit>().fetchPaidFeesDetails(
                  PaidFeesRequest(
                    accyear: _selectedAccYear!,
                    admno: AppData.admissionNo!,
                  ),
                );

                context.read<UnPaidFeeCubit>().fetchUnPaidFeesDetails(
                  PaidFeesRequest(
                    accyear: _selectedAccYear!,
                    admno: AppData.admissionNo!,
                  ),
                );

                // NEW: keep processing-ledger list in sync here too
                context.read<FeesCubit>().fetchProcessingFeeDetails(
                  PaidFeesRequest(
                    accyear: _selectedAccYear!,
                    admno: AppData.admissionNo!,
                  ),
                );
              }
            },
            builder: (context, state) {
              return PopupMenuButton<String>(
                color: Colors.white,
                offset: const Offset(0, 40),
                enabled: accYears.isNotEmpty,
                onSelected: (value) {
                  setState(() {
                    _selectedAccYear = value;
                    _selectedDetails.clear();
                  });

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

                  // NEW: refresh processing-ledger list on year switch
                  context.read<FeesCubit>().fetchProcessingFeeDetails(
                    PaidFeesRequest(
                      accyear: value,
                      admno: AppData.admissionNo!,
                    ),
                  );
                },
                itemBuilder: (context) => accYears
                    .map(
                      (datum) => PopupMenuItem<String>(
                    value: datum.accYear,
                    child: Text(datum.accYear),
                  ),
                )
                    .toList(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedAccYear ?? "Loading...",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isOverall ? Colors.white : Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: isOverall ? Colors.white : Colors.black,
                    ),
                  ],
                ),
              );
            },
          ),
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

        if (paidState is FeesPaidSuccess) {
          totalPaid = paidState.feePaidResult.data.fold(0.0, (sum, fee) {
            return sum + _parseAmount(fee.totalPaidAmount);
          });
        }

        return BlocBuilder<UnPaidFeeCubit, UnPaidFeeState>(
          builder: (context, unpaidState) {

            if (unpaidState is FeesUnPaidSuccess) {
              totalPending = unpaidState.feeUnPaidResult.data.fold(0.0, (
                  sum,
                  fee,
                  ) {
                return sum + _parseAmount(fee.totalBalance);
              });
            }
            if(unpaidState is CheckFeeStatusSuccess){

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
                      isLoading: _isAccYearLoading || _isPaidLoading,
                      color: Colors.green,
                    ),
                  ),
                  Container(width: 1, height: 82, color: Colors.grey.shade300),
                  Expanded(
                    child: _summaryItem(
                      title: 'Pending',
                      subtitle: '(This Year)',
                      amount: _formatAmount(totalPending),
                      isLoading: _isAccYearLoading || _isPendingLoading,
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
    required bool isLoading,
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
        SizedBox(
          height: 30,
          child: Center(
            child: isLoading
                ? SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: color,
              ),
            )
                : Text(
              amount,
              style: TextStyle(
                fontSize: 25,
                color: color,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
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