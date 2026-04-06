import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/cubit/feed_cubit.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(icon: Icons.home, label: 'Home', size: 100),
      _NavItem(icon: Icons.school_outlined, label: 'Student',size: 32),
      _NavItem(icon: Icons.notifications_outlined, label: 'Notifications',size: 32),
    ];

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isSelected = selectedIndex == index;

            return GestureDetector(
              // onTap: () => onItemSelected(index),
              onTap: (){

                // if (index == 0 ) {
                //   context.read<FeedCubit>().fetchFeeds(
                //     FetchFeedParameter(
                //       //accYear: AppData.accYear!,
                //       standardId: AppData.studentStdId!,
                //       divisionId: AppData.studentDivId!,
                //     ),
                //   );
                //   onItemSelected(index);
                // }
                // else{
                //   onItemSelected(index);
                // }
                onItemSelected(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 16 : 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.pink.shade600 : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      items[index].icon,
                      color: isSelected ? Colors.white : Colors.grey,
                      size: 23,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 6),
                      Text(
                        items[index].label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final double size;


  _NavItem({required this.icon, required this.label,this.size = 24});
}
