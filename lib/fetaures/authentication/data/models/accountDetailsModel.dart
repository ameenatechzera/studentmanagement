class AccountDetails {
  final String admissionNo;
  final String dob;
  final String stdId;
  final String divId;
  final String accYear;
  final String name;

  AccountDetails({required this.admissionNo, required this.dob ,
    required this.stdId, required this.divId, required this.accYear , required this.name});

  Map<String, dynamic> toJson() {
    return {
      'admissionNo': admissionNo,
      'dob': dob,
      'stdId': stdId,
      'divId': divId,
      'accYear': accYear,
      'name': name


    };
  }

  factory AccountDetails.fromJson(Map<String, dynamic> json) {
    return AccountDetails(
      admissionNo: json['admissionNo'],
      dob: json['dob'],
      stdId: json['stdId'],
        divId: json['divId'],
      accYear: json['accYear'],
        name : json['name']

    );
  }
}