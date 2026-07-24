import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/feeSaveResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paid_fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/offlinePaymentSaveRequest.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paymentSaveRequest.dart';
import 'package:studentmanagement/fetaures/fees/domain/repositories/fees_repository.dart';

class SaveOfflineFeesDetailsUseCase
    implements UseCaseWithParams<FeeSaveResult, OfflineFeePayRequest> {
  final FeesRepository _authRepository;

  SaveOfflineFeesDetailsUseCase(this._authRepository);

  @override
  ResultFuture<FeeSaveResult> call(OfflineFeePayRequest request) async =>
      _authRepository.saveOfflineFeesDetails(request);
}