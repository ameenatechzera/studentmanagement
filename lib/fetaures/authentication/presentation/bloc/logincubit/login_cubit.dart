import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/device_register_result.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/device_register_request.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/device_register_usecase.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginServerUseCase _loginUseCase;
  final CheckDeviceRegisterStatusUseCase _checkDeviceRegisterStatusUseCase;

  LoginCubit({
    required LoginServerUseCase loginServerUseCase,
    required CheckDeviceRegisterStatusUseCase checkDeviceRegisterStatusUseCase,
  }) : _loginUseCase = loginServerUseCase,
       _checkDeviceRegisterStatusUseCase = checkDeviceRegisterStatusUseCase,
       super(LoginInitial());

  Future<void> loginUser(LoginRequest loginRequest) async {
    emit(LoginLoading());
    try {
      final result = await _loginUseCase(loginRequest);

      result.fold(
        (failure) {
          print('failure ${failure.message}');
          emit(LoginFailure(failure.message));
        },
        (loginResponse) {
          emit(LoginSuccess(loginResponse));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(LoginFailure('An unexpected error occurred'));
    }
  }

  Future<void> checkDeviceRegisterStatus(DeviceRegisterRequest request) async {
    print('DeviceRegisterRequest $request');
    emit(DeviceRegisterLoading());
    try {
      final result = await _checkDeviceRegisterStatusUseCase(request);

      result.fold(
        (failure) {
          emit(DeviceRegisterStatusFailure(failure.message));
        },
        (loginResponse) {
          emit(DeviceRegisterStatusSuccess(loginResponse));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(DeviceRegisterStatusFailure('An unexpected error occurred'));
    }
  }
}
