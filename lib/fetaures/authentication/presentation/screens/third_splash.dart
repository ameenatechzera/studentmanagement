import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/forth_splash.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/login_screen.dart';

class ThirdSplashScreen extends StatelessWidget {
  const ThirdSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF807FD8),
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: size.height * .50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF807FD8),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),

                child: Stack(
                  children: [
                    Positioned(
                      left: -220,
                      top: 10,
                      bottom: 9,
                      child: Transform.rotate(
                        angle: 1.2,
                        child: Image.asset(
                          "assets/images/mask_bg.png",
                          // color: Colors.white,
                          // height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 82),
                        child: Image.asset(
                          'assets/images/ChatGPT Image May 7, 2026, 10_03_06 AM 1.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * .04),

              Text(
                'Track student progress',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * .065,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E85C7),
                ),
              ),
              SizedBox(height: size.height * .025),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  'A complete school management solution to stay connected with your child’s school anytime, anywhere.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height * .03),

              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _dot(isActive: false), // current splash
                    const SizedBox(width: 6),
                    _dot(isActive: true),
                    const SizedBox(width: 6),
                    _dot(isActive: false),
                    const SizedBox(width: 6),
                    _dot(isActive: false),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * .07,
                  vertical: size.height * .030,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// SKIP
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        AppNavigator.pushReplacementSlide(
                          context: context,
                          page: LoginScreen(),
                        );
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          AppNavigator.pushReplacementSlide(
                            context: context,
                            page: ForthSplashScreen(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF807FD8),
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                          elevation: 4,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),

      width: isActive ? 24 : 8,
      height: isActive ? 4 : 8,

      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF807FD8) : Colors.grey.shade400,

        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
