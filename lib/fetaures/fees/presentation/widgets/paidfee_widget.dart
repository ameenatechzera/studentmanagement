import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/amount_column.dart';

class PaidFee extends StatelessWidget {
  const PaidFee({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeesCubit, FeesState>(
      builder: (context, state) {
        if (state is FeesInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FeesPaidSuccess) {
          final feesList = state.feePaidResult.data; // your API list

          return ListView.builder(
            itemCount: feesList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final fee = feesList[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 42,
                          width: 42,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD81B60),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),

                        /// TITLE
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                fee.ledgerName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 16,
                              ),
                            ],
                          ),
                        ),

                        /// DATE
                        Text(
                          "",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// TOTAL AMOUNT
                    Text(
                      "₹${fee.balanceAmount}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),

                    /// AMOUNT DETAILS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AmountColumn(
                          title: "Due Amount",
                          value: fee.totalAmount,
                        ),
                        AmountColumn(
                          title: "Paid Amount",
                          value: fee.paidAmount,
                        ),
                        AmountColumn(
                          title: "Balance",
                          value: fee.balanceAmount,
                          valueColor: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }

        if (state is FeesPaidFailure) {
          return Center(child: Text(state.error));
        }

        return const SizedBox();
      },
    );
  }
}
