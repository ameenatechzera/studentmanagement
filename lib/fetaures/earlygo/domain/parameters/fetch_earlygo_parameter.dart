class FetchEarlyGoParameter {

  final String accYear;
  final String admNo;

  FetchEarlyGoParameter({

    required this.accYear,
    required this.admNo,
  });

  Map<String, dynamic> toJson() {
    return {

      "AccYear": accYear,
      "Admno": admNo,
    };
  }
}
