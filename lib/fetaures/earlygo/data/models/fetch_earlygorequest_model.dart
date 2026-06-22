import 'package:studentmanagement/fetaures/earlygo/domain/entities/fetch_earlygorequest_entity.dart';

class FetchEarlyLeaveResponseModel extends FetchEarlyLeaveResponse {
  FetchEarlyLeaveResponseModel({
    super.status,
    super.error,
    List<EarlyLeaveDetailsModel>? super.data,
  });

  factory FetchEarlyLeaveResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchEarlyLeaveResponseModel(
      status: json['status'],
      error: json['error'],
      data: json['data'] != null
          ? List<EarlyLeaveDetailsModel>.from(
              json['data'].map((x) => EarlyLeaveDetailsModel.fromJson(x)),
            )
          : [],
    );
  }
}

class EarlyLeaveDetailsModel extends EarlyLeaveDetails {
  EarlyLeaveDetailsModel({
    super.id,
    super.requestNo,
    super.accYear,
    super.admno,
    super.requestDate,
    super.earlyLeaveDate,
    super.leaveTime,
    super.reason,
    super.pickupPersonName,
    super.pickupPersonMobile,
    super.pickupPersonRelation,
    super.teacherStatus,
    super.employeeId,
    super.teacherRemarks,
    super.teacherApprovedAt,
    super.finalStatus,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    super.branchId,
  });

  factory EarlyLeaveDetailsModel.fromJson(Map<String, dynamic> json) {
    return EarlyLeaveDetailsModel(
      id: json['Id'],
      requestNo: json['requestNo'],
      accYear: json['AccYear'],
      admno: json['Admno'],
      requestDate: json['RequestDate'],
      earlyLeaveDate: json['EarlyLeaveData'],
      leaveTime: json['LeaveTime'],
      reason: json['Reason'],
      pickupPersonName: json['PickupPersonName'],
      pickupPersonMobile: json['PickupPersonMobile'],
      pickupPersonRelation: json['PickupPersonRelation'],
      teacherStatus: json['TeacherStatus'],
      employeeId: json['employeeId'],
      teacherRemarks: json['TeacherRemarks'],
      teacherApprovedAt: json['TeacherApprovedAt'],
      finalStatus: json['FinalStatus'],
      createdDate: json['CreatedDate'],
      createdUser: json['CreatedUser'],
      modifiedDate: json['ModifiedDate'],
      modifiedUser: json['ModifiedUser'],
      branchId: json['branchId'],
    );
  }
}
