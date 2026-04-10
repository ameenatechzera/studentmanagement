import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paid_fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/domain/repositories/fees_repository.dart';

class FetchPaidFeesDetailsUseCase
    implements UseCaseWithParams<PaidFeeResult, PaidFeesRequest> {
  final FeesRepository _authRepository;

  FetchPaidFeesDetailsUseCase(this._authRepository);

  @override
  ResultFuture<PaidFeeResult> call(PaidFeesRequest request) async =>
      _authRepository.fetchPaidFees(request);
}
