
import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/materials/data/models/fetch_materials_model.dart';
import 'package:studentmanagement/fetaures/materials/data/models/fetch_materialsbysubject_model.dart';
import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_materialsbysubjectId.dart';
import 'package:studentmanagement/fetaures/materials/domain/repositories/material_repository.dart';

class FetchMaterialBySubjectUseCase
    implements
        UseCaseWithParams<FetchMaterialsbySubjectModel, FetchMaterialBySubjectIdParameter> {
  final MaterialRepository _materialRepository;

  FetchMaterialBySubjectUseCase(this._materialRepository);

  @override
  ResultFuture<FetchMaterialsbySubjectModel> call(
      FetchMaterialBySubjectIdParameter params,
      ) async {
    return _materialRepository.fetchMaterialsBySubjectId(params);
  }
}
