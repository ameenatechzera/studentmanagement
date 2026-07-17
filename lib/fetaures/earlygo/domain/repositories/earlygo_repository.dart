import 'package:studentmanagement/core/data/models/common_response_model.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/earlygo/data/models/fetch_earlygorequest_model.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/parameters/fetch_earlygo_parameter.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/parameters/save_earlyleave_parameter.dart';

abstract class EarlyLeaveRepository {
  ResultFuture<FetchEarlyLeaveResponseModel> fetchEarlyLeave(FetchEarlyGoParameter request);
  ResultFuture<CommonResponseModel> saveEarlyLeave(
    SaveEarlyLeaveParameter params,
  );
}
