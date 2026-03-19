import 'package:studentmanagement/fetaures/marklist/domain/entities/fetch_examterm_entity.dart';

class FetchExamTermResponseModel extends FetchExamTermEntity {
  FetchExamTermResponseModel({
    super.status,
    super.error,
    List<FetchExamTermDetailsModel>? super.data,
  });

  factory FetchExamTermResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchExamTermResponseModel(
      status: json['status'],
      error: json['error'],
      data: json['data'] != null
          ? List<FetchExamTermDetailsModel>.from(
              json['data'].map((x) => FetchExamTermDetailsModel.fromJson(x)),
            )
          : [],
    );
  }
}

class FetchExamTermDetailsModel extends FetchExamTermDetails {
  FetchExamTermDetailsModel({
    super.examTermId,
    super.examTermName,
    super.status,
    super.branchId,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
  });

  factory FetchExamTermDetailsModel.fromJson(Map<String, dynamic> json) {
    return FetchExamTermDetailsModel(
      examTermId: json['ExamTermId'],
      examTermName: json['ExamTermName'],
      status: json['Status'],
      branchId: json['branchId'],
      createdDate: json['CreatedDate'],
      createdUser: json['CreatedUser'],
      modifiedDate: json['ModifiedDate'],
      modifiedUser: json['ModifiedUser'],
    );
  }
}
