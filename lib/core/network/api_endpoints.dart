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
    return '$baseUrl/student-login';
  }

  /// Returns the full URL for Device Register
  static String getDeviceRegisterStatusPath(String baseUrl) {
    return '$baseUrl/check-registration-status';
  }

  /// Returns the full URL for timetable
  static String getTimeTablePath(String baseUrl) {
    return '$baseUrl/gettimetableby-accyear';
  }

  /// Returns the full URL for diary
  static String getDiaryFetchPath(String baseUrl) {
    return '$baseUrl/get-classdiary-byadmno';
  }

  /// Returns the full URL for Fees / Get Fees Paid
  static String getFeesPaidServerPath(String baseUrl) {
    return '$baseUrl/feePaidList';
  }

  /// Returns the full URL for Fees / Get Fees UnPaid
  static String getFeesUnPaidServerPath(String baseUrl) {
    return '$baseUrl/getUnpaidfee-byadmno';
  }

  /// Returns the full URL for Fees / Get Fees UnPaid
  static String getFeedPath(String baseUrl) {
    return '$baseUrl/feed-report';
  }

  /// Returns the full URL for examterms
  static String getExamTermPath(String baseUrl) {
    return '$baseUrl/ExamTerms/1';
  }

  /// Returns the full URL for fetchingmarklist
  static String getMarkListPath(String baseUrl) {
    return '$baseUrl/single-student-marklist-term-type';
  }

  /// Returns the full URL for fetchingmaterials
  static String getMaterialsPath(String baseUrl) {
    return '$baseUrl/class-wise-material-get';
  }
}
