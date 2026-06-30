import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:studentmanagement/core/utils/widgets/app_snackbar.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/account_details_model.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/cubit/feed_cubit.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/main_screen.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
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

class _Login_ScreenState extends State<Login_Screen> {
  final TextEditingController admNoCtrl = TextEditingController();

  final TextEditingController dobCtrl = TextEditingController();

  final TextEditingController _deviceIdController = TextEditingController();
  bool _isProcessing = false;

  String schoolName = '';
  Map<String, dynamic>? branchData;
  // ── ADDED: error state variables ──
  String? _admNoError;
  String? _dobError;
  // ─────────────────────────────────

  @override
  void initState() {
    getDeviceId();
    loadBranchData();
    super.initState();
  }

  // ── ADDED: validation method ──
  bool _validateInputs() {
    setState(() {
      _admNoError = null;
      _dobError = null;
    });

    bool isValid = true;

    if (admNoCtrl.text.trim().isEmpty) {
      setState(() => _admNoError = 'Please enter admission number');
      isValid = false;
    }

    if (dobCtrl.text.trim().isEmpty) {
      setState(() => _dobError = 'Please enter date of birth');
      isValid = false;
    } else {
      final dobPattern = RegExp(r'^\d{2}-\d{2}-\d{4}$');
      if (!dobPattern.hasMatch(dobCtrl.text.trim())) {
        setState(() => _dobError = 'Entered DOB not in the format DD-MM-YYYY');
        isValid = false;
      }
    }

    return isValid;
  }

  // ─────────────────────────────
  Future<void> loadBranchData() async {
    final data = await SharedPreferenceHelper().getBranchData();

    print("Login Screen Branch Data: $data");
    print("Banner Image: ${data?['bannerImage']}");

    setState(() {
      branchData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // // Top Image Section
              // Container(
              //   height: 340,
              //   width: double.infinity,
              //   decoration: const BoxDecoration(
              //     borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(50),
              //     ),
              //     image: DecorationImage(
              //       image: AssetImage('assets/images/dummy_image.png'),

              //       fit: BoxFit.cover,
              //     ),
              //   ),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: const Color(0xFF8B84E8).withOpacity(0.55),
              //       borderRadius: const BorderRadius.only(
              //         bottomLeft: Radius.circular(50),
              //       ),
              //     ),
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 24,
              //       vertical: 40,
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Text(
              //           "Welcome",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 42,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         SizedBox(height: 8),
              //         Text(
              //           AppData.schoolName ?? 'School Name',
              //           style: const TextStyle(
              //             color: Colors.white,
              //             fontSize: 22,
              //             fontWeight: FontWeight.w700,
              //           ),
              //         ),
              //         SizedBox(height: 20),
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                height: 340,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                  ),
                  image: DecorationImage(
                    image:
                        (branchData?["bannerImage"] != null &&
                            branchData!["bannerImage"]
                                .toString()
                                .trim()
                                .isNotEmpty)
                        ? NetworkImage(branchData!["bannerImage"])
                        : const AssetImage("assets/images/dummy_image.png")
                              as ImageProvider,
                    fit: BoxFit.cover,
                    onError: (_, __) {},
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B84E8).withOpacity(0.55),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppData.schoolName ?? 'School Name',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Title
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 35),

              // Admission Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                // ── ADDED: wrapped in Column for error text ──
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      textInputAction: TextInputAction.next,
                      controller: admNoCtrl,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9]'),
                        ),
                        // UpperCaseTextFormatter(),
                      ],
                      textCapitalization: TextCapitalization.characters,
                      // ── ADDED: clear error on typing ──
                      onChanged: (_) {
                        if (_admNoError != null) {
                          setState(() => _admNoError = null);
                        }
                      },
                      // ─────────────────────────────────
                      decoration: InputDecoration(
                        hintText: "Admission",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // ── ADDED: red border when error ──
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: _admNoError != null
                                ? Colors.red
                                : Colors.grey.shade400,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: _admNoError != null
                                ? Colors.red
                                : const Color(0xFF8B84E8),
                            width: 1.5,
                          ),
                        ),
                        // ─────────────────────────────────
                      ),
                    ),
                    // ── ADDED: error message below field ──
                    if (_admNoError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6, left: 4),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _admNoError!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    // ──────────────────────────────────────
                  ],
                ),
                // ────────────────────────────────────────────
              ),

              const SizedBox(height: 20),

              // DOB Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                // ── ADDED: wrapped in Column for error text ──
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: dobCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [DateInputFormatter()],
                      // ── ADDED: clear error on typing ──
                      onChanged: (_) {
                        if (_dobError != null) {
                          setState(() => _dobError = null);
                        }
                      },
                      // ─────────────────────────────────
                      decoration: InputDecoration(
                        hintText: "DOB (DD-MM--YYYY)",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                        suffixIcon: const Icon(Icons.calendar_month),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // ── ADDED: red border when error ──
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: _dobError != null
                                ? Colors.red
                                : Colors.grey.shade400,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: _dobError != null
                                ? Colors.red
                                : const Color(0xFF8B84E8),
                            width: 1.5,
                          ),
                        ),
                        // ─────────────────────────────────
                      ),
                    ),
                    // ── ADDED: error message below field ──
                    if (_dobError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6, left: 4),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _dobError!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    // ──────────────────────────────────────
                  ],
                ),
                // ────────────────────────────────────────────
              ),

              const SizedBox(height: 50),

              // Login Button
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) async {
                  if (state is LoginSuccess) {
                    final sharedPrefHelper = SharedPreferenceHelper();

                    await sharedPrefHelper.setToken(state.loginResponse.token);
                    await sharedPrefHelper.saveLoginResponse(
                      state.loginResponse,
                    );
                    await sharedPrefHelper.saveClassAndDivision(
                      state.loginResponse.student!.studentStandard +
                          '-' +
                          state.loginResponse.student!.studentDivision,
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
                    AppData.gender = state.loginResponse.student!.gender
                        .toString();
                    AppData.studentClass =
                        '${state.loginResponse.student!.studentStandard}-${state.loginResponse.student!.studentDivision}'
                            .toString();
                    AppData.feeCollectionStatus =
                        state.loginResponse.student?.feeCollectionStatus ??
                        false;
                    print('AppData.studentClass ${AppData.studentClass}');
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
                    await context.read<FeedCubit>().fetchFeeds(
                      FetchFeedParameter(
                        standardId: AppData.studentStdId!,
                        divisionId: AppData.studentDivId!,
                        fromDateTime: "",
                        admissionNo: AppData.admissionNo!,
                        branchId: 1,
                        page: 1,
                        perPage: 12,
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
                  // if (state is LoginSuccess) {
                  //   setState(() {
                  //     _isProcessing = true;
                  //   });

                  //   try {
                  //     final sharedPrefHelper = SharedPreferenceHelper();

                  //     await sharedPrefHelper.setToken(
                  //       state.loginResponse.token,
                  //     );
                  //     await sharedPrefHelper.saveLoginResponse(
                  //       state.loginResponse,
                  //     );

                  //     AppData.admissionNo = state.loginResponse.student!.admno
                  //         .toString();

                  //     AppData.studentName = state.loginResponse.student!.name
                  //         .toString();

                  //     AppData.studentStdId = state
                  //         .loginResponse
                  //         .student!
                  //         .currentStudentStandardId
                  //         .toString();

                  //     AppData.studentDivId = state
                  //         .loginResponse
                  //         .student!
                  //         .currentStudentDivisionId
                  //         .toString();

                  //     AppData.accYear = state.loginResponse.student!.accYear
                  //         .toString();

                  //     AppData.gender = state.loginResponse.student!.gender
                  //         .toString();

                  //     AppData.studentClass =
                  //         '${state.loginResponse.student!.studentStandard} - ${state.loginResponse.student!.studentDivision}';

                  //     AppData.profileUrl = state.loginResponse.student!.imageUrl
                  //         .toString();

                  //     await SharedPreferenceHelper.saveNewAccount(
                  //       AccountDetails(
                  //         admissionNo: state.loginResponse.student!.admno
                  //             .toString(),
                  //         dob: state.loginResponse.student!.dob.toString(),
                  //         stdId: state
                  //             .loginResponse
                  //             .student!
                  //             .currentStudentStandardId
                  //             .toString(),
                  //         divId: state
                  //             .loginResponse
                  //             .student!
                  //             .currentStudentDivisionId,
                  //         accYear: state.loginResponse.student!.accYear
                  //             .toString(),
                  //         name: state.loginResponse.student!.name,
                  //       ),
                  //     );

                  //     print("🚀 STARTING FEED SYNC");

                  //     await context.read<FeedCubit>().fetchFeeds(
                  //       FetchFeedParameter(
                  //         standardId: AppData.studentStdId!,
                  //         divisionId: AppData.studentDivId!,
                  //         fromDateTime: "",
                  //         admissionNo: AppData.admissionNo!,
                  //         branchId: 1,
                  //         page: 1,
                  //         perPage: 12,
                  //       ),
                  //     );

                  //     print("✅ FEED SYNC COMPLETED");

                  //     if (!mounted) return;

                  //     AppNavigator.pushAndRemoveUntilSlide(
                  //       context: context,
                  //       page: MainScreen(loginResponse: state.loginResponse),
                  //       predicate: (route) => false,
                  //     );
                  //   } catch (e) {
                  //     print("❌ LOGIN FLOW ERROR: $e");
                  //   } finally {
                  //     if (mounted) {
                  //       setState(() {
                  //         _isProcessing = false;
                  //       });
                  //     }
                  //   }
                  // }
                  if (state is DeviceRegisterStatusSuccess) {
                    if (state.registerResponse.data?.result == true) {
                      final apiDob = convertDobToApiFormat(dobCtrl.text.trim());

                      if (apiDob.isEmpty) {
                        showAppSnackBar(context, 'Invalid DOB format');
                        return;
                      }

                      context.read<LoginCubit>().loginUser(
                        LoginRequest(admno: admNoCtrl.text.trim(), dob: apiDob),
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
                  final isLoading = state is LoginLoading || _isProcessing;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B84E8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: isLoading
                            ? null
                            : () {
                                // ── ADDED: validate before proceeding ──
                                if (!_validateInputs()) return;
                                // ───────────────────────────────────────

                                // context.read<LoginCubit>().checkDeviceRegisterStatus(
                                //   DeviceRegisterRequest(
                                //     deviceId: _deviceIdController.text.toString(),
                                //   ),
                                // );
                                final apiDob = convertDobToApiFormat(
                                  dobCtrl.text.trim(),
                                );

                                if (apiDob.isEmpty) {
                                  showAppSnackBar(
                                    context,
                                    'Invalid DOB format',
                                  );
                                  return;
                                }
                                context.read<LoginCubit>().loginUser(
                                  LoginRequest(
                                    admno: admNoCtrl.text.trim(),
                                    dob: apiDob,
                                  ),
                                );
                              },
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        // child: const Text(
                        //   "Login",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 15,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                      ),
                    ),
                  );
                },
              ),
            ],
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

    schoolName = (await SharedPreferenceHelper().getSchoolName())!;
    print('schoolName $schoolName');
    return 'unsupported-platform';
  }
}
