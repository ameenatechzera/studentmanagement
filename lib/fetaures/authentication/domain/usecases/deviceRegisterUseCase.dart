import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/deviceRegisterResult.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/deviceRegisterRequest.dart';
import 'package:studentmanagement/fetaures/authentication/domain/repositories/auth_repository.dart';

class CheckDeviceRegisterStatusUseCase
    implements UseCaseWithParams<DeviceRegisterResult,DeviceRegisterRequest> {
  final AuthRepository _authRepository;

  CheckDeviceRegisterStatusUseCase(this._authRepository);

  @override
  ResultFuture<DeviceRegisterResult> call(DeviceRegisterRequest) async =>
      _authRepository.deviceRegister(DeviceRegisterRequest);
}