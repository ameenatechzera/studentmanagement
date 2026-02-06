class LoginRequest {
  final String admno;
  final String dob;

  LoginRequest({required this.admno, required this.dob});

  Map<String, dynamic> toJson() => {"admno": admno, "dob": dob};
}
