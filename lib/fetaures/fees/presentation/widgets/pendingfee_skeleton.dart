import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// 🔥 SHIMMER SKELETON (MATCHES EXACT UI)
class PendingFeeShimmer extends StatelessWidget {
  const PendingFeeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔵 Circle Placeholder
                    Container(
                      height: 44,
                      width: 44,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 12),

                    // 🔵 Text Skeleton
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 14,
                                width: 80,
                                color: Colors.white,
                              ),
                              Container(
                                height: 14,
                                width: 50,
                                color: Colors.white,
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          Container(
                            height: 12,
                            width: double.infinity,
                            color: Colors.white,
                          ),

                          const SizedBox(height: 6),

                          Container(
                            height: 12,
                            width: 150,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
