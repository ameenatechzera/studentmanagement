import 'package:flutter/material.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/forth_splash.dart';

class ThirdSplashScreen extends StatelessWidget {
  const ThirdSplashScreen({super.key});

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
                SizedBox(height: 10),
                Image.asset('assets/images/Group 40.png'),
                SizedBox(height: 10),

                Text(
                  'Smart & Simple',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),

                Center(
                  child: Text(
                    'Track records, schedules, and daily activities '
                    'with an easy-to-use interface.',
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
                        _dot(isActive: false), // current splash
                        const SizedBox(width: 6),
                        _dot(isActive: true),
                        const SizedBox(width: 6),
                        _dot(isActive: false),
                      ],
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        //width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ForthSplashScreen();
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFC4005F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text('Next'),
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

  Widget _dot({required bool isActive}) {
    return Container(
      width: isActive ? 10 : 8,
      height: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFC4005F) : Colors.grey.shade400,
        shape: BoxShape.circle,
      ),
    );
  }
}
