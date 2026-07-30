import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/feeProcessingResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paid_fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/domain/repositories/fees_repository.dart';

class FetchPaidFeeProcessingListUseCase
    implements UseCaseWithParams<FeeProcessingResult, PaidFeesRequest> {
  final FeesRepository _authRepository;

  FetchPaidFeeProcessingListUseCase(this._authRepository);

  @override
  ResultFuture<FeeProcessingResult> call(PaidFeesRequest request) async =>
      _authRepository.fetchPaidFeeProcessing(request);
}
