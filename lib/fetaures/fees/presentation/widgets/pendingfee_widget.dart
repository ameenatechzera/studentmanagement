import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/fetaures/fees/presentation/unPaidFee/un_paid_fee_cubit.dart';

class PendingFee extends StatelessWidget {
  const PendingFee({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnPaidFeeCubit, UnPaidFeeState>(
      builder: (context, state) {
        if (state is FeeUnpaidInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FeesUnPaidSuccess) {
          final feesUnpaidList = state.feeUnPaidResult.data; // your API list

          return ListView.builder(
            itemCount: feesUnpaidList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final fee = feesUnpaidList[index];

              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD81B60),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.schedule,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fee.ledgerName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              fee.dueAmount,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Last Date On ${fee.dueDate!}",
                              style: TextStyle(fontSize: 13, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      // const Text("12-11-2025", style: TextStyle(fontSize: 12)),
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
