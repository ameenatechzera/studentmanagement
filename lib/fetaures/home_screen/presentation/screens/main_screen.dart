import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/fetchschool_parameter.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/home_screen.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/noti.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/settings.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/student_screenN.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/custom_bottombar.dart';
import 'package:studentmanagement/fetaures/settings/presentation/screens/settings_screen.dart';
import 'package:studentmanagement/services/notification_service.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

class MainScreen extends StatefulWidget {
  final LoginResponseResult loginResponse;
  const MainScreen({super.key, required this.loginResponse});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    notificationsetup();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      StudentScreenN(loginResponse: widget.loginResponse),
      SettingsScreen(),
      const NotificationScreen(),
    ];

    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: IndexedStack(index: _currentIndex, children: screens),
    //   bottomNavigationBar: SafeArea(
    //     child: CustomBottomBar(
    //       selectedIndex: _currentIndex,
    //       onItemSelected: (index) {
    //         setState(() {
    //           _currentIndex = index;
    //         });
    //       },
    //     ),
    //   ),
    // );
    return Scaffold(
      extendBody: true,
      //backgroundColor: Colors.white,
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

  Future<void> notificationsetup() async {
    try {
      await Firebase.initializeApp(); // ← no options needed
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      await NotificationService.init();
      await MediaStore.ensureInitialized();

    } catch (e, st) {
      debugPrint('Startup error: $e\n$st');
    }
  }
}
