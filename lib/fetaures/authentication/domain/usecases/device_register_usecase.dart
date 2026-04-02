import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/device_register_result.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/device_register_request.dart';
import 'package:studentmanagement/fetaures/authentication/domain/repositories/auth_repository.dart';

class CheckDeviceRegisterStatusUseCase
    implements UseCaseWithParams<DeviceRegisterResult, DeviceRegisterRequest> {
  final AuthRepository _authRepository;

  CheckDeviceRegisterStatusUseCase(this._authRepository);

  @override
  ResultFuture<DeviceRegisterResult> call(
    DeviceRegisterRequest request,
  ) async => _authRepository.deviceRegister(request);
}
