import 'package:flutter/material.dart';

class AppData {
  static String appVersion =
      '2.2'; //extra 1 not passing issue (formtype) fixed 05-02-2026
  static String? admissionNo;
  static String? mobileNo;
  static String? emailId;
  static int? admissionId;
  static String? studentName;
  static String? studentStdId;
  static String? studentDivId;
  static String? accYear;
  static String? dob;
  static String? profileUrl;
  static String? gender;
  static String? schoolName;
  static String? appType;
  static String? profile64;
  static String? merchantKey;
  static String? schoolCode;
  static String? saltKey;
  // Simple global state manager
  static ValueNotifier<bool> showDeleteButtonNotifier = ValueNotifier(false);
  //final deleteButtonNotifier = ValueNotifier<bool>(false);
  static String? branchName;
  static String? logo;
  static String? place;
  static String? studentClass;
  static int? branchId;
  static bool feeCollectionStatus = false;
}
