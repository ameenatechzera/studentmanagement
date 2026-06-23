import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/home_screen.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/noti.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/student_screenN.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/custom_bottombar.dart';
import 'package:studentmanagement/fetaures/settings/presentation/screens/settings_screen.dart';
import 'package:studentmanagement/services/notification_service.dart';

class MainScreen extends StatefulWidget {
  final LoginResponseResult loginResponse;
  const MainScreen({super.key, required this.loginResponse});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // bool _isLoading = true;
  int _currentIndex = 0;

  // Future<void> _loadInitialData() async {
  //   await context.read<FeedCubit>().fetchFeeds(
  //     FetchFeedParameter(
  //       standardId: AppData.studentStdId!,
  //       divisionId: AppData.studentDivId!,
  //       fromDateTime: "",
  //       admissionNo: AppData.admissionNo!,
  //       branchId: 1,
  //       page: 1,
  //       perPage: 12,
  //     ),
  //   );

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  void initState() {
    //notificationsetup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("🏠 MAIN SCREEN BUILD");
    // if (_isLoading) {
    //   return const Scaffold(body: Center(child: CircularProgressIndicator()));
    // }

    final screens = [
      const HomeScreen(),
      StudentScreenN(loginResponse: widget.loginResponse),
      SettingsScreen(),
      const NotificationScreen(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: screens),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomBar(
              selectedIndex: _currentIndex,
              onItemSelected: (index) {
                setState(() => _currentIndex = index);
              },
            ),
          ),
        ],
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
