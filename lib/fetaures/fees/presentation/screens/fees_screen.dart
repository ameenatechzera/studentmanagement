import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/unPaidFee/un_paid_fee_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/accyearselect_widget.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/paidfee_widget.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/pendingfee_widget.dart';

import '../../domain/entities/accyearResult.dart';

final TextEditingController accYearController = TextEditingController();

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  @override
  void initState() {
    context.read<FeesCubit>().fetchAccYearList();


    super.initState();
  }

  final List<Datum> accYears = [];
  String? _selectedAccYear;

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
                    accyear:AppData.accYear!,
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
                      _selectedAccYear = value; // ✅ persists across rebuilds
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
                  listener: (context, state) {

                  },
                  builder: (context, state) {
                    if (state is FeeUnpaidInitial) {
                      return const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }
                    if (state is FeesUnPaidSuccess) {
                      if( state.feeUnPaidResult.data.isNotEmpty) {
                        return PendingFee(
                          feesUnpaidList: state.feeUnPaidResult,);
                      }
                      else{
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
                  listener: (context, state) {

                  },
                  builder: (context, state) {
                    if (state is FeesInitial) {
                      return const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }
                    if (state is FeesPaidSuccess) {
                      return PaidFee(feePaidResult: state.feePaidResult,);
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
    );
  }
}
