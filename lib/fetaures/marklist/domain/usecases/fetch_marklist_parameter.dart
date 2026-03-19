import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/marklist/data/models/fetch_marklist_model.dart';
import 'package:studentmanagement/fetaures/marklist/domain/parameter/fetch_marklist_parameter.dart';
import 'package:studentmanagement/fetaures/marklist/domain/repositories/marklist_repository.dart';

class FetchMarkListUseCase
    implements
        UseCaseWithParams<FetchMarkListResponseModel, FetchMarkListParameter> {
  final MarkListRepository _markListRepository;

  FetchMarkListUseCase(this._markListRepository);

  @override
  ResultFuture<FetchMarkListResponseModel> call(
    FetchMarkListParameter params,
  ) async {
    return _markListRepository.fetchMarkList(params);
  }
}
