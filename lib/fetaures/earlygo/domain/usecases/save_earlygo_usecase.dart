import 'package:studentmanagement/core/data/models/common_response_model.dart';
import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/parameters/save_earlyleave_parameter.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/repositories/earlygo_repository.dart';

class SaveEarlyLeaveUseCase
    implements UseCaseWithParams<CommonResponseModel, SaveEarlyLeaveParameter> {
  final EarlyLeaveRepository _repository;

  SaveEarlyLeaveUseCase(this._repository);

  @override
  ResultFuture<CommonResponseModel> call(SaveEarlyLeaveParameter params) async {
    return _repository.saveEarlyLeave(params);
  }
}
