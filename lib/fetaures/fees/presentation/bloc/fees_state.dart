part of 'fees_cubit.dart';

@immutable
sealed class FeesState {}

final class FeesInitial extends FeesState {}

final class AccYearsInitial extends FeesState {}


final class FeesPaidFailure extends FeesState {
  final String error;

  FeesPaidFailure(this.error);
}

final class AccYearFailure extends FeesState {
  final String error;

  AccYearFailure(this.error);
}

final class FeesPaidSuccess extends FeesState {
  final PaidFeeResult feePaidResult;

  FeesPaidSuccess(this.feePaidResult);
}

final class AccYearSuccess extends FeesState {
  final AccYearResult accYearResult;

  AccYearSuccess(this.accYearResult);
}

final class FeeUnpaid_Loading extends FeesState {}

final class FeeProcessingFeeListLoading extends FeesState {}

final class FeeSave_Loading extends FeesState {}
final class FeeCollectionCheckLoading extends FeesState {}
final class FeeSaveCheckLoading extends FeesState {}

final class FeeUnPaid_Failure extends FeesState {
  final String error;

  FeeUnPaid_Failure(this.error);
}
final class LoginCheckFailure extends FeesState {
  final String error;

   LoginCheckFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class FeeCheckFailure extends FeesState {
  final String error;

  FeeCheckFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class LoginCheckSuccess extends FeesState {
  final LoginResponseResult loginResponse;

   LoginCheckSuccess(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

final class CheckFeeStatusSuccess extends FeesState {
  final FeePaymentExistResult response;

  CheckFeeStatusSuccess(this.response);

  @override
  List<Object> get props => [response];
}

final class SaveFees_Failure extends FeesState {
  final String error;

  SaveFees_Failure(this.error);
}

final class FeesUnPaid_Success extends FeesState {
  final UnpaidFeeResult feeUnPaidResult;

  FeesUnPaid_Success(this.feeUnPaidResult);
}

final class FeeSave_Success extends FeesState {
  final FeeSaveResult feeSaveResult;

  FeeSave_Success(this.feeSaveResult);
}

final class FeesPaidLoading extends FeesState {}
final class FeeProcessingFeeListFailure extends FeesState {
  final String error;

  FeeProcessingFeeListFailure(this.error);
}
final class FeeProcessingFeeSuccess extends FeesState {
  final FeeProcessingResult feeProcessingFeeResult;

  FeeProcessingFeeSuccess(this.feeProcessingFeeResult);
}
