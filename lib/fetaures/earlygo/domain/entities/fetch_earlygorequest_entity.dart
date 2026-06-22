class FetchEarlyLeaveResponse {
  final int? status;
  final bool? error;
  final List<EarlyLeaveDetails>? data;

  FetchEarlyLeaveResponse({this.status, this.error, this.data});
}

class EarlyLeaveDetails {
  final int? id;
  final String? requestNo;
  final String? accYear;
  final String? admno;
  final String? requestDate;
  final String? earlyLeaveDate;
  final String? leaveTime;
  final String? reason;
  final String? pickupPersonName;
  final String? pickupPersonMobile;
  final String? pickupPersonRelation;
  final String? teacherStatus;
  final int? employeeId;
  final String? teacherRemarks;
  final String? teacherApprovedAt;
  final String? finalStatus;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final int? branchId;

  EarlyLeaveDetails({
    this.id,
    this.requestNo,
    this.accYear,
    this.admno,
    this.requestDate,
    this.earlyLeaveDate,
    this.leaveTime,
    this.reason,
    this.pickupPersonName,
    this.pickupPersonMobile,
    this.pickupPersonRelation,
    this.teacherStatus,
    this.employeeId,
    this.teacherRemarks,
    this.teacherApprovedAt,
    this.finalStatus,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
    this.branchId,
  });
}
