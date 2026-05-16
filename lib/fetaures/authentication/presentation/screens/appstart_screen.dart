import 'package:flutter/material.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/registerScreen.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/register_screen.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/main_splash.dart';

class AppStartScreen extends StatefulWidget {
  const AppStartScreen({super.key});

  @override
  State<AppStartScreen> createState() => _AppStartScreenState();
}

class _AppStartScreenState extends State<AppStartScreen> {
  @override
  void initState() {
    super.initState();
    _decideStartScreen();
  }

  Future<void> _decideStartScreen() async {
    final pref = SharedPreferenceHelper();

    final isRegistered = await pref.isSchoolRegistered();
    print("isRegistered: $isRegistered");

    /// Small delay so logo is visible
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    if (!isRegistered) {
      /// 👉 First time → Register
      Navigator.pushReplacement(
        context,
        // MaterialPageRoute(builder: (_) => const RegisterScreen()),
        MaterialPageRoute(builder: (_) => const RegisterCodePage()),
      );
    } else {
      /// 👉 Already registered → Splash flow
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainSplashScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Image.asset('assets/icons/cristal_icon.png', height: 180),
        ),
      ),
    );
  }
}
