import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:studentmanagement/core/utils/widgets/app_snackbar.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/account_details_model.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/main_screen.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

import '../../../../core/config/colors.dart';

class LoginScreen_1 extends StatefulWidget {
  const LoginScreen_1({super.key});

  @override
  State<LoginScreen_1> createState() => _LoginScreenState_1();
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final isDeleting = newValue.text.length < oldValue.text.length;

    if (isDeleting) {
      return newValue;
    }

    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.length > 8) {
      return oldValue;
    }

    String formatted = '';

    if (digits.length >= 2) {
      formatted = digits.substring(0, 2) + '-';
    } else {
      formatted = digits;
    }

    if (digits.length > 2) {
      if (digits.length >= 4) {
        formatted += digits.substring(2, 4) + '-';
      } else {
        formatted += digits.substring(2);
      }
    }

    if (digits.length > 4) {
      formatted += digits.substring(4);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

String convertDobToApiFormat(String input) {
  final parts = input.split('-');

  if (parts.length != 3) return '';

  final day = parts[0].padLeft(2, '0');
  final month = parts[1].padLeft(2, '0');
  final year = parts[2];

  return '$year-$month-$day';
}

class _LoginScreenState_1 extends State<LoginScreen_1> {
  final TextEditingController admNoCtrl = TextEditingController();

  final TextEditingController dobCtrl = TextEditingController();

  final TextEditingController _deviceIdController = TextEditingController();

  @override
  void initState() {
    getDeviceId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                SizedBox(
                  height: 150,
                  child: Image.asset('assets/images/Group 46.png'),
                ),
                SizedBox(height: 20),

                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                /// EMAIL / USERNAME
                TextFormField(
                  controller: admNoCtrl,
                  decoration: InputDecoration(
                    labelText: 'Admission No',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// PASSWORD
                TextFormField(
                  controller: dobCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [DateInputFormatter()],
                  decoration: InputDecoration(
                    labelText: 'DOB (DD-MM-YYYY)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                /// pushes content up
                // const Expanded(child: SizedBox()),
                //  Spacer(),
                SizedBox(height: 20),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) async {
                    if (state is LoginSuccess) {
                      final sharedPrefHelper = SharedPreferenceHelper();

                      await sharedPrefHelper.setToken(
                        state.loginResponse.token,
                      );
                      await sharedPrefHelper.saveLoginResponse(
                        state.loginResponse,
                      );
                      AppData.admissionNo = state.loginResponse.student!.admno
                          .toString();
                      AppData.studentName = state.loginResponse.student!.name
                          .toString();
                      AppData.studentStdId = state
                          .loginResponse
                          .student!
                          .currentStudentStandardId
                          .toString();
                      AppData.studentDivId = state
                          .loginResponse
                          .student!
                          .currentStudentDivisionId
                          .toString();
                      AppData.accYear = state.loginResponse.student!.accYear
                          .toString();
                      print(
                        'profileUrl ${state.loginResponse.student!.imageUrl.toString()}',
                      );
                      AppData.profileUrl = state.loginResponse.student!.imageUrl
                          .toString();
                      await SharedPreferenceHelper.saveNewAccount(
                        AccountDetails(
                          admissionNo: state.loginResponse.student!.admno
                              .toString(),
                          dob: state.loginResponse.student!.dob.toString(),
                          stdId: state
                              .loginResponse
                              .student!
                              .currentStudentStandardId
                              .toString(),
                          divId: state
                              .loginResponse
                              .student!
                              .currentStudentDivisionId,
                          accYear: state.loginResponse.student!.accYear
                              .toString(),
                          name: state.loginResponse.student!.name,
                        ),
                      );
                      AppNavigator.pushAndRemoveUntilSlide(
                        context: context,
                        page: MainScreen(loginResponse: state.loginResponse),
                        predicate: (route) => false,
                      );
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return MainScreen(
                      //         loginResponse: state.loginResponse,
                      //       );
                      //     },
                      //   ),
                      // );
                    }
                    if (state is DeviceRegisterStatusSuccess) {
                      if (state.registerResponse.data?.result == true) {
                        final apiDob = convertDobToApiFormat(
                          dobCtrl.text.trim(),
                        );

                        if (apiDob.isEmpty) {
                          showAppSnackBar(context, 'Invalid DOB format');
                          return;
                        }

                        context.read<LoginCubit>().loginUser(
                          LoginRequest(
                            admno: admNoCtrl.text.trim(),
                            dob: apiDob,
                          ),
                        );
                        // context.read<LoginCubit>().loginUser(
                        //   LoginRequest(
                        //     admno: admNoCtrl.text,
                        //     dob: dobCtrl.text,
                        //   ),
                        // );
                      } else {
                        showAppSnackBar(context, 'Device Not Registered..!');
                      }
                    }
                    if (state is DeviceRegisterStatusFailure) {
                      showAppSnackBar(context, state.error);
                    }
                    if (state is LoginFailure) {
                      showAppSnackBar(context, 'Invalid Credentials');
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // context.read<LoginCubit>().checkDeviceRegisterStatus(
                          //   DeviceRegisterRequest(
                          //     deviceId: _deviceIdController.text.toString(),
                          //   ),
                          // );
                          final apiDob = convertDobToApiFormat(
                            dobCtrl.text.trim(),
                          );

                          if (apiDob.isEmpty) {
                            showAppSnackBar(context, 'Invalid DOB format');
                            return;
                          }
                          context.read<LoginCubit>().loginUser(
                            LoginRequest(
                              admno: admNoCtrl.text.trim(),
                              dob: apiDob,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appThemeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      print('androidInfo.id ${androidInfo.id}');
      _deviceIdController.text = androidInfo.id.toString();
      return androidInfo.id; // ANDROID_ID
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown-ios-id';
    }

    return 'unsupported-platform';
  }
}
