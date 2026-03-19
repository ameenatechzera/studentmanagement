class FetchMarkListEntity {
  final int? status;
  final bool? error;
  final String? message;
  final List<FetchMarkListDetails>? data;

  FetchMarkListEntity({this.status, this.error, this.message, this.data});
}

class FetchMarkListDetails {
  final String? admno;
  final String? te;
  final String? ce;
  final String? grade;
  final String? absent;
  final String? status;
  final String? narration;
  final String? name;
  final String? gender;
  final String? subjectName;

  FetchMarkListDetails({
    this.admno,
    this.te,
    this.ce,
    this.grade,
    this.absent,
    this.status,
    this.narration,
    this.name,
    this.gender,
    this.subjectName,
  });
}
