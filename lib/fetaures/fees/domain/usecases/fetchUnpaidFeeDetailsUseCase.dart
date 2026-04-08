import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/unpaid%20fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/domain/repositories/fees_repository.dart';

class FetchUnPaidFeesDetailsUseCase
    implements UseCaseWithParams<UnpaidFeeResult, PaidFeesRequest> {
  final FeesRepository _authRepository;

  FetchUnPaidFeesDetailsUseCase(this._authRepository);

  @override
  ResultFuture<UnpaidFeeResult> call(PaidFeesRequest request) async =>
      _authRepository.fetchUnPaidFees(request);
}
