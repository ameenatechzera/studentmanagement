import 'package:studentmanagement/core/data/models/common_response_model.dart';
import 'package:studentmanagement/core/domain/entities/common_response_entity.dart';
import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/feeExistCheckResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/feePayExistRequest.dart';
import 'package:studentmanagement/fetaures/fees/domain/repositories/fees_repository.dart';

class CheckFeeExistUseCase
    implements UseCaseWithParams<FeePaymentExistResult, FeePaymentExistRequest> {
  final FeesRepository _authRepository;

  CheckFeeExistUseCase(this._authRepository);

  @override
  ResultFuture<FeePaymentExistResult> call(
      FeePaymentExistRequest request) async =>
      _authRepository.checkFeePayExistStatus(request);
}