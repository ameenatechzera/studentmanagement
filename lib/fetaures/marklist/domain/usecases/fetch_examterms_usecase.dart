import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/marklist/data/models/fetch_examterm_model.dart';
import 'package:studentmanagement/fetaures/marklist/domain/repositories/marklist_repository.dart';

class FetchExamTermsUseCase
    implements UseCaseWithoutParams<FetchExamTermResponseModel> {
  final MarkListRepository _markListRepository;

  FetchExamTermsUseCase(this._markListRepository);

  @override
  ResultFuture<FetchExamTermResponseModel> call() async {
    return _markListRepository.fetchExamTerms();
  }
}
