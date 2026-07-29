import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/accyearResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paymentGatewayDetails.dart';
import 'package:studentmanagement/fetaures/fees/domain/repositories/fees_repository.dart';

class FetchPaymentGatewayDetailsUseCase
    implements UseCaseWithoutParams<FeePaymentGatewayDetails> {
  final FeesRepository _authRepository;

  FetchPaymentGatewayDetailsUseCase(this._authRepository);

  @override
  ResultFuture<FeePaymentGatewayDetails> call() async =>
      _authRepository.fetchPaymentGatewayDetails();
}
