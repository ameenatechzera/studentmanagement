import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paidFeeResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/fetchPaidFeesDetailsUseCase.dart';

part 'fees_state.dart';

class FeesCubit extends Cubit<FeesState> {
  final FetchPaidFeesDetailsUseCase _fetchPaidFeesDetailsUseCase;
  FeesCubit({required FetchPaidFeesDetailsUseCase fetchPaidFeesDetailsUseCase}) : _fetchPaidFeesDetailsUseCase = fetchPaidFeesDetailsUseCase,
        super(FeesInitial());

  Future<void> fetchPaidFeesDetails(PaidFeesRequest request) async {
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
}
