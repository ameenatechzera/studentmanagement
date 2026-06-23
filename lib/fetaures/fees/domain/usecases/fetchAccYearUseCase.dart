import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/accyearResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/repositories/fees_repository.dart';

class FetchAccYearListUseCase
    implements UseCaseWithoutParams<AccYearResult> {
  final FeesRepository _authRepository;

  FetchAccYearListUseCase(this._authRepository);

  @override
  ResultFuture<AccYearResult> call() async =>
      _authRepository.fetchAccYearsList();
}
