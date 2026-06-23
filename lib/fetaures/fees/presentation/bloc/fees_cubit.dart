import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/accyearResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paid_fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/unpaid%20fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/fetchAccYearUseCase.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/fetchPaidFeesDetailsUseCase.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/fetchUnpaidFeeDetailsUseCase.dart';

part 'fees_state.dart';

class FeesCubit extends Cubit<FeesState> {
  final FetchPaidFeesDetailsUseCase _fetchPaidFeesDetailsUseCase;
  final FetchAccYearListUseCase _fetchAccYearListUseCase;
  final FetchUnPaidFeesDetailsUseCase _fetchUnPaidFeesDetailsUseCase;

  FeesCubit({required FetchPaidFeesDetailsUseCase fetchPaidFeesDetailsUseCase , required FetchAccYearListUseCase fetchAccYearListUseCase,
  required FetchUnPaidFeesDetailsUseCase fetchUnPaidFeesDetailsUseCase})
    : _fetchPaidFeesDetailsUseCase = fetchPaidFeesDetailsUseCase,
        _fetchAccYearListUseCase = fetchAccYearListUseCase,
        _fetchUnPaidFeesDetailsUseCase = fetchUnPaidFeesDetailsUseCase,
      super(FeesInitial());

  Future<void> fetchUnPaidFeeDetails(PaidFeesRequest request) async {
    print('PaidFeesRequest ${request.toJson()}');
    emit(FeeUnpaid_Loading());
    try {
      final result = await _fetchUnPaidFeesDetailsUseCase(request);

      result.fold(
            (failure) {
          emit(FeeUnPaid_Failure(failure.message));
        },
            (response) {
          emit(FeesUnPaid_Success(response));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(FeeUnPaid_Failure('An unexpected error occurred'));
    }
  }
  Future<void> fetchPaidFeesDetails(PaidFeesRequest request) async {
    print('PaidFeesRequest ${request.toJson()}');

    emit(FeesInitial());
    try {
      final result = await _fetchPaidFeesDetailsUseCase(request);

      result.fold(
        (failure) {
          emit(FeesPaidFailure(failure.message));
        },
        (loginResponse) {
          emit(FeesPaidSuccess(loginResponse));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(FeesPaidFailure('An unexpected error occurred'));
    }
  }

  Future<void> fetchAccYearList() async {
    emit(AccYearsInitial());
    try {
      final result = await _fetchAccYearListUseCase();

      result.fold(
            (failure) {
          emit(AccYearFailure(failure.message));
        },
            (accYearResponse) {
          emit(AccYearSuccess(accYearResponse));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(FeesPaidFailure('An unexpected error occurred'));
    }
  }
}
