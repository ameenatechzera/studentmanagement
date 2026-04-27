part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class DeviceRegisterLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginResponseResult loginResponse;

  const LoginSuccess(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

final class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class DeviceRegisterStatusFailure extends LoginState {
  final String error;

  const DeviceRegisterStatusFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class DeviceRegisterStatusSuccess extends LoginState {
  final DeviceRegisterResult registerResponse;

  const DeviceRegisterStatusSuccess(this.registerResponse);

  @override
  List<Object> get props => [registerResponse];
}

class FetchSchoolLoading extends LoginState {}

class FetchSchoolSuccess extends LoginState {
  final FetchSchoolEntity response;

  const FetchSchoolSuccess(this.response);
}

class FetchSchoolFailure extends LoginState {
  final String message;

  const FetchSchoolFailure(this.message);
}

class GetBranchLoading extends LoginState {}

class GetBranchSuccess extends LoginState {
  final GetBranchEntity response;

  const GetBranchSuccess(this.response);
}

class GetBranchFailure extends LoginState {
  final String message;

  const GetBranchFailure(this.message);
}
