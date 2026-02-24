

import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/domain/repositories/auth_repository.dart';

class LoginServerUseCase
    implements UseCaseWithParams<LoginResponseResult, LoginRequest> {
  final AuthRepository _authRepository;

  LoginServerUseCase(this._authRepository);

  @override
  ResultFuture<LoginResponseResult> call(LoginRequest loginRequest) async =>
      _authRepository.loginServer(loginRequest);
}
