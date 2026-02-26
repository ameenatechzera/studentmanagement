import 'package:flutter/material.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/second_splash.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/main_screen.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({super.key});

  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
    // Future.delayed(const Duration(seconds: 3), () {
    //   AppNavigator.pushSlide(context: context, page: SecondSplashScreen());
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const SecondSplashScreen()),
    // );
    // });
  }

  Future<void> _checkLogin() async {
    final sharedPrefHelper = SharedPreferenceHelper();

    final loginResponse = await sharedPrefHelper.getLoginResponse();

    await Future.delayed(const Duration(seconds: 2));

    if (loginResponse != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MainScreen(loginResponse: loginResponse),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SecondSplashScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(flex: 2),

              /// TOP LOGO
              Image.asset(
                'assets/images/a6fb42e4c9f5bc22db568a0987d1a371f0df1bf3.png',
                height: 250,
              ),

              const SizedBox(height: 20),

              /// SCHOOL NAME
              const Text(
                'Schools Namehere',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              const Spacer(flex: 3),

              /// BOTTOM IMAGE / BRAND
              Image.asset(
                'assets/images/079fdab992cfa5175f199dd2d2134e8f0a9f0af6.png',
                height: 200,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
