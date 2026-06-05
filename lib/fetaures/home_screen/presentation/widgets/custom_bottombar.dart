// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:studentmanagement/fetaures/authentication/domain/parameters/fetchschool_parameter.dart';
// import 'package:studentmanagement/fetaures/home_screen/presentation/cubit/feed_cubit.dart';
// import 'package:studentmanagement/services/shared_preference_helper.dart';

// class CustomBottomBar extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onItemSelected;

//   const CustomBottomBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onItemSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       _NavItem(icon: Icons.home, label: 'Home', size: 100),
//       _NavItem(icon: Icons.school_outlined, label: 'Student', size: 32),
//       _NavItem(
//         icon: Icons.notifications_outlined,
//         label: 'Notifications',
//         size: 32,
//       ),
//     ];

//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             offset: Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: List.generate(items.length, (index) {
//           final isSelected = selectedIndex == index;

//           return GestureDetector(
//             // onTap: () => onItemSelected(index),
//             onTap: () async {
//               final schoolCode = await SharedPreferenceHelper().getSchoolCode();
//               if (index == 0) {
//                 context.read<FeedCubit>().fetchVersionDetails(
//                   FetchSchoolRequest(slno: schoolCode),
//                 );
//                 onItemSelected(index);
//               } else {
//                 onItemSelected(index);
//               }
//             },
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               padding: EdgeInsets.symmetric(
//                 horizontal: isSelected ? 16 : 12,
//                 vertical: 8,
//               ),
//               decoration: BoxDecoration(
//                 color: isSelected ? Colors.pink.shade600 : Colors.transparent,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     items[index].icon,
//                     color: isSelected ? Colors.white : Colors.grey,
//                     size: 23,
//                   ),
//                   if (isSelected) ...[
//                     const SizedBox(width: 6),
//                     Text(
//                       items[index].label,
//                       style: const TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// class _NavItem {
//   final IconData icon;
//   final String label;
//   final double size;

//   _NavItem({required this.icon, required this.label, this.size = 24});
// }
import 'package:flutter/material.dart';

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
      (Icons.home_outlined, "Home"),
      (Icons.school_outlined, "Student"),
      (Icons.settings_outlined, "Settings"),
      (Icons.notifications_none_rounded, "Notification"),
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
      // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F23),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(items.length, (index) {
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () => onItemSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 18 : 0,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2E85C7)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(items[index].$1, color: Colors.white, size: 24),

                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      Text(
                        items[index].$2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
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
