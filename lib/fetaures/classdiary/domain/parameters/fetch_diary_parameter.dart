class FetchDiaryParameter {
  final String admNo;
  final String accYear;

  FetchDiaryParameter({required this.admNo, required this.accYear});

  Map<String, dynamic> toJson() {
    return {"AdmNo": admNo, "AccYear": accYear};
  }
}
