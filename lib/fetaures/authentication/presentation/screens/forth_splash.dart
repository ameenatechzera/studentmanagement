import 'package:flutter/material.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/login_screen.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/register_screen.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/widget/dot.dart';

import 'loginSecond.dart';

class ForthSplashScreen extends StatelessWidget {
  const ForthSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // SizedBox(height: 10),
                Image.asset('assets/images/Group 41.png'),
                SizedBox(height: 10),
                Text(
                  'Ready to Begin?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),

                Center(
                  child: Text(
                    'Let’s get started and make your work faster '
                    'and smarter.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        dot(isActive: false), // current splash
                        const SizedBox(width: 6),
                        dot(isActive: false),
                        const SizedBox(width: 6),
                        dot(isActive: true),
                      ],
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          AppNavigator.pushSlide(
                            context: context,
                            page: LoginScreen_1(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC4005F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
