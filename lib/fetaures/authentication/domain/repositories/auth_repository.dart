

import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';

abstract class AuthRepository {

  ResultFuture<LoginResponseResult> loginServer(LoginRequest loginRequest);
}
