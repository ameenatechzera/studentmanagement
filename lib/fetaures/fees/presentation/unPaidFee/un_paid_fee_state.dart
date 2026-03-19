part of 'un_paid_fee_cubit.dart';

@immutable
sealed class UnPaidFeeState {}

final class FeeUnpaidInitial extends UnPaidFeeState {}

final class FeeUnPaidFailure extends UnPaidFeeState {
  final String error;

  FeeUnPaidFailure(this.error);
}

final class FeesUnPaidSuccess extends UnPaidFeeState {
  final UnpaidFeeResult feeUnPaidResult;

  FeesUnPaidSuccess(this.feeUnPaidResult);
}
