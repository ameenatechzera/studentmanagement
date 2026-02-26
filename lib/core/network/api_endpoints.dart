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
}
