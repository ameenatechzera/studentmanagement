import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/device_register_result.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/getbranch_entitiy.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/getschool_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/device_register_request.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/fetchschool_parameter.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/device_register_usecase.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/getbranch_usecase.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/getschool_usecase.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginServerUseCase _loginUseCase;
  final CheckDeviceRegisterStatusUseCase _checkDeviceRegisterStatusUseCase;
  final FetchSchoolUseCase _fetchSchoolUseCase;
  final GetBranchUseCase _getBranchUseCase;
  LoginCubit({
    required LoginServerUseCase loginServerUseCase,
    required CheckDeviceRegisterStatusUseCase checkDeviceRegisterStatusUseCase,
    required FetchSchoolUseCase fetchSchoolUseCase,
    required GetBranchUseCase getBranchUseCase,
  }) : _loginUseCase = loginServerUseCase,
       _checkDeviceRegisterStatusUseCase = checkDeviceRegisterStatusUseCase,
       _fetchSchoolUseCase = fetchSchoolUseCase,
       _getBranchUseCase = getBranchUseCase,
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

  Future<void> fetchSchools(FetchSchoolRequest request) async {
    print('FetchSchoolRequest: ${request.toJson()}');

    emit(FetchSchoolLoading());

    try {
      final result = await _fetchSchoolUseCase(request);

      result.fold(
        (failure) {
          print('❌ FetchSchool failure: ${failure.message}');
          emit(FetchSchoolFailure(failure.message));
        },
        (response) {
          emit(FetchSchoolSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      print('❌ Exception during fetchSchools: $e');
      print('Stacktrace: $stacktrace');
      emit(FetchSchoolFailure('An unexpected error occurred'));
    }
  }

  Future<void> getBranchDetails() async {
    emit(GetBranchLoading());

    try {
      final result = await _getBranchUseCase();

      result.fold(
        (failure) {
          print('❌ GetBranch failure: ${failure.message}');
          emit(GetBranchFailure(failure.message));
        },
        (response) {
          emit(GetBranchSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      print('❌ Exception during getBranchDetails: $e');
      print('Stacktrace: $stacktrace');
      emit(GetBranchFailure('An unexpected error occurred'));
    }
  }
}
