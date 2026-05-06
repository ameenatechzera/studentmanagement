class ApiConstants {
  // -------------------
  // Dynamic Endpoints
  // -------------------

  /// Returns the full URL for Register / Get Company endpoint
  static String getRegisterServerPath(String baseUrl) {
    return '$baseUrl/company/get-company';
  }

  /// Returns the full URL for Login endpoint
  static String getLoginPath(String baseUrl) {
    return '${baseUrl}app/student-login';
  }

  /// Returns the full URL for Device Register
  static String getDeviceRegisterStatusPath(String baseUrl) {
    return '$baseUrl/check-registration-status';
  }

  /// Returns the full URL for timetable
  static String getTimeTablePath(String baseUrl) {
    return '${baseUrl}app/gettimetableby-accyear';
  }

  /// Returns the full URL for diary
  static String getDiaryFetchPath(String baseUrl) {
    return '${baseUrl}app/get-classdiary-byadmno';
  }

  /// Returns the full URL for Fees / Get Fees Paid
  static String getFeesPaidServerPath(String baseUrl) {
    return '${baseUrl}app/feePaidList';
  }

  /// Returns the full URL for Fees / Get Fees UnPaid
  static String getFeesUnPaidServerPath(String baseUrl) {
    return '${baseUrl}app/getUnpaidfee-byadmno';
  }

  /// Returns the full URL for Fees / Get Fees UnPaid
  static String getFeedPath(String baseUrl) {
    return '${baseUrl}app/feed-report';
  }

  /// Returns the full URL for examterms
  static String getExamTermPath(String baseUrl) {
    return '${baseUrl}app/ExamTerms/1';
  }

  /// Returns the full URL for fetchingmarklist
  static String getMarkListPath(String baseUrl) {
    return '${baseUrl}app/single-student-marklist-term-type';
  }

  /// Returns the full URL for fetchingmaterials
  static String getMaterialsPath(String baseUrl) {
    return '${baseUrl}app/class-wise-material-get';
  }

  /// Returns the full URL for fetch subjects
  static String getSubjectsPath(String baseUrl) {
    return '${baseUrl}app/subjects/1';
  }


  /// Returns the full URL for attendecereportbydate

  static String getAttendanceReportByDatePath(String baseUrl) {
    return '${baseUrl}app/student-wise-attendance-report-bydate';
  }

  /// Returns the full URL for attendecereportbymonth

  static String getAttendanceReportByMonthPath(String baseUrl) {
    return '${baseUrl}app/student-wise-attendance-report-bymonth';
  }

  /// Returns the full URL forfeedACTION
  static String feedActionPath(String baseUrl) {
    return '${baseUrl}app/feed-action';
  }

  // /// Returns the full URL for getschool
  // static String getFetchSchoolPath(String baseUrl) {
  //   return '${baseUrl}app/get-school';
  // }

  // /// Returns the full URL for getbranchid
  // static String getBranchDetailsPath(String baseUrl) {
  //   return '${baseUrl}app/branch-byid/1';
  // }
}
