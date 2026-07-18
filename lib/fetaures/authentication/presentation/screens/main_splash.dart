// import 'package:flutter/material.dart';
// import 'package:studentmanagement/core/appdata/appdata.dart';
// import 'package:studentmanagement/fetaures/authentication/presentation/screens/second_splash.dart';
// import 'package:studentmanagement/fetaures/home_screen/presentation/screens/main_screen.dart';
// import 'package:studentmanagement/services/shared_preference_helper.dart';

// class MainSplashScreen extends StatefulWidget {
//   const MainSplashScreen({super.key});

//   @override
//   State<MainSplashScreen> createState() => _MainSplashScreenState();
// }

// class _MainSplashScreenState extends State<MainSplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLogin();
//   }

//   Future<void> _checkLogin() async {
//     final sharedPrefHelper = SharedPreferenceHelper();

//     final loginResponse = await sharedPrefHelper.getLoginResponse();
//     AppData.admissionNo = loginResponse?.student!.admno.toString();
//     AppData.studentName = loginResponse?.student!.name.toString();
//     ;
//     AppData.studentStdId = loginResponse?.student!.currentStudentStandardId
//         .toString();
//     ;
//     AppData.studentDivId = loginResponse?.student!.currentStudentDivisionId
//         .toString();
//     AppData.accYear = loginResponse?.student!.accYear.toString();

//     await Future.delayed(const Duration(seconds: 2));

//     if (loginResponse != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => MainScreen(loginResponse: loginResponse),
//         ),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => SecondSplashScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             children: [
//               const Spacer(flex: 2),

//               /// TOP LOGO
//               Image.asset('assets/images/fsp_logo.png', height: 250),

//               const SizedBox(height: 20),

//               /// SCHOOL NAME
//               const Text(
//                 'First Step Preschool',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),

//               const Spacer(flex: 3),

//               /// BOTTOM IMAGE / BRAND
//               Image.asset(
//                 'assets/images/cristal_horizontal.png',
//                 height: 200,
//                 fit: BoxFit.contain,
//               ),

//               const SizedBox(height: 12),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/second_splash.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/main_screen.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({super.key});

  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  String? branchName;
  String? logo;
  @override
  void initState() {
    super.initState();
    _loadBranchData();
    _checkLogin();
  }

  Future<void> _loadBranchData() async {
    final pref = SharedPreferenceHelper();
    final branch = await pref.getBranchData();

    if (branch != null) {
      AppData.branchName = branch['branchName'];
      AppData.logo = branch['logo'];
      AppData.place = branch['place'];
      AppData.branchId = branch['branchId'];

      setState(() {
        branchName = branch['branchName'];
        logo = branch['logo'];
      });
    }
  }

  Future<void> _checkLogin() async {
    final sharedPrefHelper = SharedPreferenceHelper();

    final loginResponse = await sharedPrefHelper.getLoginResponse();
    AppData.admissionNo = loginResponse?.student!.admno.toString();
    AppData.studentName = loginResponse?.student!.name.toString();
    ;
    AppData.studentStdId = loginResponse?.student!.currentStudentStandardId
        .toString();
    ;
    AppData.studentDivId = loginResponse?.student!.currentStudentDivisionId
        .toString();
    AppData.accYear = loginResponse?.student!.accYear.toString();

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

  /// 🔥 COMMON LOGO (API or fallback)
  // Widget buildLogo(double height) {
  //   return logo != null && logo!.isNotEmpty
  //       ? Image.network(
  //           logo ?? '',
  //           height: height,
  //           fit: BoxFit.contain,
  //           errorBuilder: (_, __, ___) => Image.asset(
  //             'assets/images/cristal_horizontal.png', // fallback
  //             height: height,
  //           ),
  //         )
  //       : Image.asset(
  //           'assets/images/cristal_horizontal.png', // fallback
  //           height: height,
  //         );
  // }
  Widget buildLogo(double height) {
    Uint8List? bytes;
    if (logo != null && logo!.isNotEmpty) {
      try {
        bytes = base64Decode(logo!);
      } catch (_) {
        bytes = null;
      }
    }

    return bytes != null
        ? Image.memory(
      bytes,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Image.asset(
        'assets/images/cristal_horizontal.png', // fallback
        height: height,
      ),
    )
        : Image.asset(
      'assets/images/cristal_horizontal.png', // fallback
      height: height,
    );
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
              buildLogo(250),

              /// TOP LOGO
              //  Image.asset('assets/images/fsp_logo.png', height: 250),
              const SizedBox(height: 20),

              /// SCHOOL NAME
              Text(
                branchName ?? 'School Name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.4,
                ),
              ),

              const Spacer(flex: 3),

              /// BOTTOM IMAGE / BRAND
              buildLogo(150),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
