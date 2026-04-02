import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/unPaidFee/un_paid_fee_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/paidfee_widget.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/pendingfee_widget.dart';

class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      context.read<FeesCubit>().fetchPaidFeesDetails(
        PaidFeesRequest(accyear: '2018-2019', admno: '1000'),
      );
      context.read<UnPaidFeeCubit>().fetchUnPaidFeesDetails(
        PaidFeesRequest(accyear: '2018-2019', admno: 'kg-591'),
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Fees")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= PENDING =================
                const Text(
                  'Pending',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                PendingFee(),

                const SizedBox(height: 20),

                // ================= PAID =================
                const Text(
                  'Paid',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                PaidFee(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
