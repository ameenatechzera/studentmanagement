import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/account_details_model.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/device_register_request.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/main_screen.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

class AddAccount extends StatelessWidget {
  AddAccount({super.key});

  final TextEditingController admNoCtrl = TextEditingController();

  final TextEditingController dobCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Optional drag handle
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const Text(
              "Switch Account",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: admNoCtrl,
              decoration: const InputDecoration(
                labelText: 'Admission No',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: dobCtrl,
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) async {
                if (state is LoginSuccess) {
                  print('LoginSuccess_SwitchAccount');
                  final sharedPrefHelper = SharedPreferenceHelper();

                  await sharedPrefHelper.setToken(state.loginResponse.token);
                  await sharedPrefHelper.saveLoginResponse(state.loginResponse);
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
                  print('AppData.accYear ${AppData.accYear}');
                  await SharedPreferenceHelper.saveNewAccount(
                    AccountDetails(
                      admissionNo: state.loginResponse.student!.admno
                          .toString(),
                      dob: state.loginResponse.student!.dob.toString(),
                      stdId: state
                          .loginResponse
                          .student!
                          .currentStudentDivisionId
                          .toString(),
                      divId: state
                          .loginResponse
                          .student!
                          .currentStudentDivisionId
                          .toString(),
                      accYear: state.loginResponse.student!.accYear.toString(),
                      name: state.loginResponse.student!.name,
                    ),
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return MainScreen(loginResponse: state.loginResponse);
                      },
                    ),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    context.read<LoginCubit>().loginUser(
                      LoginRequest(admno: admNoCtrl.text, dob: dobCtrl.text),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // 👈 button color
                    foregroundColor: Colors.white, // 👈 text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        6,
                      ), // 👈 smaller radius = more rectangular
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),
                  ),
                  child: const Text('Switch'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
