class SaveEarlyLeaveParameter {
  final String requestNo;
  final String accYear;
  final String admno;
  final String requestDate;
  final String earlyLeaveDate;
  final String leaveTime;
  final String reason;
  final String pickupPersonName;
  final String pickupPersonMobile;
  final String pickupPersonRelation;
  final String teacherStatus;
  final int? employeeId;
  final String? teacherRemarks;
  final String? teacherApprovedAt;
  final String finalStatus;
  final String createdUser;
  final int branchId;

  SaveEarlyLeaveParameter({
    required this.requestNo,
    required this.accYear,
    required this.admno,
    required this.requestDate,
    required this.earlyLeaveDate,
    required this.leaveTime,
    required this.reason,
    required this.pickupPersonName,
    required this.pickupPersonMobile,
    required this.pickupPersonRelation,
    required this.teacherStatus,
    this.employeeId,
    this.teacherRemarks,
    this.teacherApprovedAt,
    required this.finalStatus,
    required this.createdUser,
    required this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      "requestNo": requestNo,
      "AccYear": accYear,
      "Admno": admno,
      "RequestDate": requestDate,
      "EarlyLeaveData": earlyLeaveDate,
      "LeaveTime": leaveTime,
      "Reason": reason,
      "PickupPersonName": pickupPersonName,
      "PickupPersonMobile": pickupPersonMobile,
      "PickupPersonRelation": pickupPersonRelation,
      "TeacherStatus": teacherStatus,
      "employeeId": employeeId,
      "TeacherRemarks": teacherRemarks,
      "TeacherApprovedAt": teacherApprovedAt,
      "FinalStatus": finalStatus,
      "CreatedUser": createdUser,
      "branchId": branchId,
    };
  }
}
