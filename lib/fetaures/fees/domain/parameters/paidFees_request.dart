class PaidFeesRequest {
  final String accyear;
  final String admno;


  PaidFeesRequest({required this.accyear, required this.admno});

  Map<String, dynamic> toJson() => {"AccYear": accyear, "Admno": admno};
}
