part of 'fees_cubit.dart';

@immutable
sealed class FeesState {}

final class FeesInitial extends FeesState {}

final class FeesPaidFailure extends FeesState {
  final String error;

   FeesPaidFailure(this.error);

  @override
  List<Object> get props => [error];
}
final class FeesPaidSuccess extends FeesState {
  final PaidFeeResult feePaidResult;

   FeesPaidSuccess(this.feePaidResult);

  @override
  List<Object> get props => [feePaidResult];
}