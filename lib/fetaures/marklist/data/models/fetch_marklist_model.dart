import 'package:studentmanagement/fetaures/marklist/domain/entities/fetch_marklist_entity.dart';

class FetchMarkListResponseModel extends FetchMarkListEntity {
  FetchMarkListResponseModel({
    super.status,
    super.error,
    super.message,
    List<FetchMarkListDetailsModel>? super.data,
  });

  factory FetchMarkListResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchMarkListResponseModel(
      status: json['status'],
      error: json['error'],
      message: json['message'],
      data: json['data'] != null
          ? List<FetchMarkListDetailsModel>.from(
              json['data'].map((x) => FetchMarkListDetailsModel.fromJson(x)),
            )
          : [],
    );
  }
}

class FetchMarkListDetailsModel extends FetchMarkListDetails {
  FetchMarkListDetailsModel({
    super.admno,
    super.te,
    super.ce,
    super.grade,
    super.absent,
    super.status,
    super.narration,
    super.name,
    super.gender,
    super.subjectName,
  });

  factory FetchMarkListDetailsModel.fromJson(Map<String, dynamic> json) {
    return FetchMarkListDetailsModel(
      admno: json['Admno'] ?? '',
      te: json['TE'] ?? '',
      ce: json['CE'] ?? '',
      grade: json['GRADE'] ?? '',
      absent: json['Absent'] ?? '',
      status: json['Status'] ?? '',
      narration: json['Narration'] ?? '',
      name: json['Name'] ?? '',
      gender: json['Gender'] ?? '',
      subjectName: json['SubjectName'] ?? '',
    );
  }
}
