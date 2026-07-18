class SaveDiaryStatusParameter {
  final String admNo;
  final String accYear;
  final String diaryId;
  final String readStatus;
  final String branchId;
  final String createdUser;
  SaveDiaryStatusParameter({required this.admNo, required this.accYear, required this.diaryId,required this.readStatus,required this.branchId,
  required this.createdUser});

  Map<String, dynamic> toJson() {
    return {"Admno": admNo, "DiaryId": diaryId,"ReadStatus": readStatus , "branchId": branchId,
      "CreatedUser":createdUser,"AccYear": accYear};
  }
}
