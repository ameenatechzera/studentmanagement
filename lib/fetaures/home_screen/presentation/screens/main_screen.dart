import 'package:flutter/material.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/home_screen.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/noti.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/settings.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/student_screen.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/custom_bottombar.dart';

class MainScreen extends StatefulWidget {
  final LoginResponseResult? loginResponse;
  const MainScreen({super.key, this.loginResponse});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      StudentScreen(loginResponse: widget.loginResponse),
      const NotificationScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
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
