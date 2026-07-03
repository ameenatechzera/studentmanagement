import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/earlygo/data/models/fetch_earlygorequest_model.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/parameters/fetch_earlygo_parameter.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/repositories/earlygo_repository.dart';

class FetchEarlyLeaveUseCase
    implements UseCaseWithParams<FetchEarlyLeaveResponseModel,FetchEarlyGoParameter> {
  final EarlyLeaveRepository _earlyLeaveRepository;

  FetchEarlyLeaveUseCase(this._earlyLeaveRepository);

  @override
  ResultFuture<FetchEarlyLeaveResponseModel> call(FetchEarlyGoParameter request) async {
    return _earlyLeaveRepository.fetchEarlyLeave(request);
  }
}
