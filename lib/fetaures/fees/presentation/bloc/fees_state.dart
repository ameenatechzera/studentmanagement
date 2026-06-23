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

final class FeeUnPaid_Failure extends FeesState {
  final String error;

  FeeUnPaid_Failure(this.error);
}

final class FeesUnPaid_Success extends FeesState {
  final UnpaidFeeResult feeUnPaidResult;

  FeesUnPaid_Success(this.feeUnPaidResult);
}