import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_status_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_status_parameter.dart';
import 'package:studentmanagement/fetaures/authentication/domain/repositories/auth_repository.dart';

class LoginStatusUseCase
    implements UseCaseWithParams<LoginStatusEntity, LoginStatusParameter> {
  final AuthRepository _authRepository;

  LoginStatusUseCase(this._authRepository);

  @override
  ResultFuture<LoginStatusEntity> call(LoginStatusParameter request) async =>
      _authRepository.loginStatus(request);
}
