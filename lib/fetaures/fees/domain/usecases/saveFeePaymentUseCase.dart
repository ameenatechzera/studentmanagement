import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/feeSaveResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paid_fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paymentSaveRequest.dart';
import 'package:studentmanagement/fetaures/fees/domain/repositories/fees_repository.dart';

class SaveFeesDetailsUseCase
    implements UseCaseWithParams<FeeSaveResult, FeeSaveRequest> {
  final FeesRepository _authRepository;

  SaveFeesDetailsUseCase(this._authRepository);

  @override
  ResultFuture<FeeSaveResult> call(FeeSaveRequest request) async =>
      _authRepository.saveFeesDetails(request);
}