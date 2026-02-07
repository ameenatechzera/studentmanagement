import 'package:flutter/material.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/screens/alldiary_screen.dart';
import 'package:studentmanagement/fetaures/fees/presentation/screens/fees_screen.dart';
import 'package:studentmanagement/fetaures/marklist/presentation/screens/marklist_screen.dart';
import 'package:studentmanagement/fetaures/timetable/presentation/screens/timetable_screen.dart';
import 'package:studentmanagement/fetaures/materials/presentation/screens/materials_screen.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Student card
              _StudentInfoCard(
                name: "Serin Johnson",
                phone: "9747958159",
                classNo: "6",
                std: "A",
                rollNo: "23",
              ),
              const SizedBox(height: 30),

              // Notification header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Notification",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Show All",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Notification card
              const _NotificationCard(
                title: "Impotent Announcement",
                subtitle:
                    "Please Note That Today Will Be A\nHalf-Day Of Classes.",
              ),
              const SizedBox(height: 22),
              // Quick access title
              const Text(
                "Quick Access",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),

              // Quick access grid (2 rows x 3 cols)
              Wrap(
                spacing: 22,
                runSpacing: 18,
                children: [
                  _QuickAccessItem(
                    label: "Fees",
                    icon: Icons.confirmation_number_outlined,
                    bubbleColor: Color(0xFFFFF3B0),
                    iconColor: Color(0xFF232323),
                    onTap: () {
                      AppNavigator.pushSlide(
                        context: context,
                        page: FeesScreen(),
                      );
                    },
                  ),
                  _QuickAccessItem(
                    label: "Time Table",
                    icon: Icons.shield_outlined,
                    bubbleColor: Color(0xFFCFF8C6),
                    iconColor: Color(0xFF1F2B1F),
                    onTap: () {
                      AppNavigator.pushSlide(
                        context: context,
                        page: TimeTableScreen(),
                      );
                    },
                  ),
                  _QuickAccessItem(
                    label: "Mark List",
                    icon: Icons.wallet_outlined,
                    bubbleColor: Color(0xFFCFF8C6),
                    iconColor: Color(0xFF1F2B1F),
                    onTap: () {
                      AppNavigator.pushSlide(
                        context: context,
                        page: MarkListScreen(),
                      );
                    },
                  ),
                  _QuickAccessItem(
                    label: "Material",
                    icon: Icons.grid_view_rounded,
                    bubbleColor: Color(0xFFBFD2FF),
                    iconColor: Color(0xFF1C2240),
                    onTap: () {
                      AppNavigator.pushSlide(
                        context: context,
                        page: MaterialsScreen(),
                      );
                    },
                  ),
                  _QuickAccessItem(
                    label: "Class Diary",
                    icon: Icons.menu_book_rounded,
                    bubbleColor: Color(0xFFBFA6FF),
                    iconColor: Color(0xFF2A1E45),
                    onTap: () {
                      AppNavigator.pushSlide(
                        context: context,
                        page: AllClassDiaryScreen(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}

class _StudentInfoCard extends StatelessWidget {
  final String name;
  final String phone;
  final String classNo;
  final String std;
  final String rollNo;

  const _StudentInfoCard({
    required this.name,
    required this.phone,
    required this.classNo,
    required this.std,
    required this.rollNo,
  });

  @override
  Widget build(BuildContext context) {
    const cardRadius = 18.0;

    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardRadius),
        gradient: const LinearGradient(
          colors: [Color(0xFF6A1232), Color(0xFF2E0A1A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar + small badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) => const AccountSwitchBottomSheet(),
                  );
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.18),
                    border: Border.all(color: Colors.white24, width: 1),
                  ),
                  child: const Center(
                    child: Icon(Icons.person, color: Colors.white, size: 24),
                  ),
                ),
              ),
              Positioned(
                bottom: -8,
                right: 2,
                left: 2,

                child: Container(
                  height: 20,
                  width: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.sync_alt,
                      size: 15,
                      color: Color(0xFF6A1232),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),

          // Text + stats
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  phone,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _MiniStat(label: "Class", value: classNo),
                    _MiniStat(label: "Std", value: std),
                    _MiniStat(label: "Roll No", value: rollNo),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;

  const _MiniStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Align(
          alignment: Alignment.center,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _NotificationCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD6E9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: const Color(0xffffc4005f),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.notifications_active_outlined,
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
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAccessItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bubbleColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _QuickAccessItem({
    required this.label,
    required this.icon,
    required this.bubbleColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: bubbleColor,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(icon, color: iconColor, size: 26),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountSwitchBottomSheet extends StatelessWidget {
  const AccountSwitchBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ===== DRAG INDICATOR =====
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 16),

          // ===== TITLE =====
          const Text(
            "Account Switch",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // ===== ACCOUNT LIST =====
          _accountTile("Serin Johnson"),
          const SizedBox(height: 12),
          _accountTile("Anna Johnson"),

          const SizedBox(height: 24),

          // ===== ADD ACCOUNT =====
          GestureDetector(
            onTap: () {
              // add account action
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.add, size: 18, color: Colors.white),
                ),
                SizedBox(width: 10),
                Text(
                  "Add Account",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _accountTile(String name) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xffffd1586f),
            radius: 24,
            child: Icon(Icons.person, color: Colors.white),
            //backgroundImage: Icon(ico),

            // AssetImage(
            //   "assets/images/a6fb42e4c9f5bc22db568a0987d1a371f0df1bf3.png",
            // ),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
