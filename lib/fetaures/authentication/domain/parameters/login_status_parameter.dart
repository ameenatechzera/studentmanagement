class LoginStatusParameter {
  final String admno;

  const LoginStatusParameter({required this.admno});

  Map<String, dynamic> toJson() {
    return {"admno": admno};
  }
}
