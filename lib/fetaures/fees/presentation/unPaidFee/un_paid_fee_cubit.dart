import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/unpaid%20fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/fetchUnpaidFeeDetailsUseCase.dart';

part 'un_paid_fee_state.dart';

class UnPaidFeeCubit extends Cubit<UnPaidFeeState> {
  final FetchUnPaidFeesDetailsUseCase _fetchUnPaidFeesDetailsUseCase;
  UnPaidFeeCubit({
    required FetchUnPaidFeesDetailsUseCase fetchUnPaidFeesDetailsUseCase,
  }) : _fetchUnPaidFeesDetailsUseCase = fetchUnPaidFeesDetailsUseCase,
       super(FeeUnpaidInitial());

  Future<void> fetchUnPaidFeesDetails(PaidFeesRequest request) async {
    emit(FeeUnpaidInitial());
    try {
      final result = await _fetchUnPaidFeesDetailsUseCase(request);

      result.fold(
        (failure) {
          emit(FeeUnPaidFailure(failure.message));
        },
        (response) {
          emit(FeesUnPaidSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(FeeUnPaidFailure('An unexpected error occurred'));
    }
  }
}
