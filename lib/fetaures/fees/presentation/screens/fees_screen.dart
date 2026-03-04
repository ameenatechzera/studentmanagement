import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';

class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      context.read<FeesCubit>().fetchPaidFeesDetails(PaidFeesRequest(accyear: '2018-2019', admno: '1000'));
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

                Container(
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
                          children: const [
                            Text(
                              "Tuition Fees",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "₹10000",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Last Date On 23-10-2025",
                              style: TextStyle(fontSize: 13, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      const Text("12-10-2025", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ================= PAID =================
                const Text(
                  'Paid',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

            BlocBuilder<FeesCubit, FeesState>(
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
                                        fee.ledgerName ?? "",
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
                              "₹${fee.amount}",
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
                                _AmountColumn(
                                  title: "Due Amount",
                                  value:"",
                                ),
                                _AmountColumn(
                                  title: "Paid Amount",
                                  value: "",
                                ),
                                _AmountColumn(
                                  title: "Balance",
                                  value: "",
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
            )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AmountColumn extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;

  const _AmountColumn({
    required this.title,
    required this.value,
    this.valueColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
