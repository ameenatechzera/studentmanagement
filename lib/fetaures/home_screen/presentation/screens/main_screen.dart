import 'package:flutter/material.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/home_screen.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/noti.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/settings.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/student_screen.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/custom_bottombar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    StudentScreen(),
    NotificationScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
