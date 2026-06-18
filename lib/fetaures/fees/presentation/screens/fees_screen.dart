import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/unPaidFee/un_paid_fee_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/accyearselect_widget.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/paidfee_widget.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/pendingfee_widget.dart';
final TextEditingController accYearController = TextEditingController();
class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      context.read<FeesCubit>().fetchPaidFeesDetails(
        PaidFeesRequest(accyear: accYearController.text.toString(), admno: AppData.admissionNo!),
      );
      context.read<UnPaidFeeCubit>().fetchUnPaidFeesDetails(
        PaidFeesRequest(accyear: accYearController.text.toString(), admno: AppData.admissionNo!),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: const Text("Fees")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= PENDING =================
                // AccYearDropdown(),
                AccYearDropdown(
                  accYears: ['2026-2027','2023-2024', '2024-2025', '2025-2026'],
                  initialValue: AppData.accYear, // optional
                  onChanged: (value) {
                    print('Selected: $value');
                    accYearController.text = value!;
                    Future.microtask(() {
                      context.read<FeesCubit>().fetchPaidFeesDetails(
                        PaidFeesRequest(accyear: accYearController.text.toString(), admno: AppData.admissionNo!),
                      );
                      context.read<UnPaidFeeCubit>().fetchUnPaidFeesDetails(
                        PaidFeesRequest(accyear: accYearController.text.toString(), admno: AppData.admissionNo!),
                      );
                    });
                  },
                ),

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


                PendingFee(),

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

                PaidFee(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


