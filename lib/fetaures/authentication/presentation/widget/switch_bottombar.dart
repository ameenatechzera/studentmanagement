import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/core/utils/widgets/app_snackbar.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/account_details_model.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/loginScreen.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/main_screen.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

class SwitchAccountBottomSheet extends StatefulWidget {
  const SwitchAccountBottomSheet({super.key});

  @override
  State<SwitchAccountBottomSheet> createState() =>
      _SwitchAccountBottomSheetState();
}

class _SwitchAccountBottomSheetState extends State<SwitchAccountBottomSheet> {
  final TextEditingController admissionController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  void dispose() {
    admissionController.dispose();
    dobController.dispose();
    super.dispose();
  }

  void onSwitch() {
    print('reached');
    final admNo = admissionController.text.trim();
    final dob = dobController.text.trim();

    if (admNo.isEmpty || dob.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }
    final apiDob = convertDobToApiFormats(dobController.text.trim());
    context.read<LoginCubit>().loginUser(
      LoginRequest(admno: admissionController.text, dob: apiDob),
    );

    //
    //
    // if (apiDob.isEmpty) {
    //   showAppSnackBar(context, 'Invalid DOB format');
    //   return;
    // }





    // TODO: call your cubit/bloc switch account logic here
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const Text(
            "Switch Account",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 20),

          // Admission No
          TextField(
            controller: admissionController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Admission No",
              hintStyle: TextStyle(color: Colors.grey.shade400),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xff807FD8)),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // DOB
          TextField(
            controller: dobController,
            keyboardType: TextInputType.datetime,
            inputFormatters: [DateInputFormatter()],
            decoration: InputDecoration(
              hintText: "DOB (DD-MM-YYYY)",
              hintStyle: TextStyle(color: Colors.grey.shade400),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xff807FD8)),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Switch Button
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
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: onSwitch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4A90E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Switch",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
String convertDobToApiFormats(String input) {
  final parts = input.split('-');

  if (parts.length != 3) return '';

  final day = parts[0].padLeft(2, '0');
  final month = parts[1].padLeft(2, '0');
  final year = parts[2];

  return '$year-$month-$day';
}