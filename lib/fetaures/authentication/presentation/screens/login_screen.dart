import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/utils/widgets/app_snackbar.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/deviceRegisterRequest.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController admNoCtrl = TextEditingController();

  final TextEditingController dobCtrl = TextEditingController();

  final _deviceIdController = TextEditingController();

  @override
  void initState() {
    getDeviceId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    admNoCtrl.text = '1220';
    dobCtrl.text = '2018-08-29';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                Image.asset('assets/images/Group 46.png'),
                SizedBox(height: 20),

                Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),

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
                  obscureText: true,
                  controller: dobCtrl,
                  decoration: InputDecoration(
                    labelText: 'DOB',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                /// pushes content up
                // const Expanded(child: SizedBox()),
                //  Spacer(),
                SizedBox(height: 200),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return MainScreen(
                              loginResponse: state.loginResponse,
                            );
                          },
                        ),
                      );
                    }
                    if (state is DeviceRegisterStatusSuccess) {
                      if(state.registerResponse.data?.result==true) {
                        context.read<LoginCubit>().loginUser(
                          LoginRequest(admno: admNoCtrl.text, dob: dobCtrl
                              .text),
                        );
                      }
                      else{
                        showAppSnackBar(context,'Device Not Registered..!');
                      }
                    }
                    if (state is DeviceRegisterStatusFailure) {
                      showAppSnackBar(context, state.error);
                    }
                    if (state is LoginFailure) {
                      showAppSnackBar(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<LoginCubit>().checkDeviceRegisterStatus(
                            DeviceRegisterRequest(
                              deviceId: _deviceIdController.text.toString(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC4005F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text('Login'),
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
