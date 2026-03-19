import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/materials/data/models/fetch_materials_model.dart';
import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_material_parameter.dart';
import 'package:studentmanagement/fetaures/materials/domain/repositories/material_repository.dart';

class FetchMaterialUseCase
    implements
        UseCaseWithParams<FetchMaterialResponseModel, FetchMaterialParameter> {
  final MaterialRepository _materialRepository;

  FetchMaterialUseCase(this._materialRepository);

  @override
  ResultFuture<FetchMaterialResponseModel> call(
    FetchMaterialParameter params,
  ) async {
    return _materialRepository.fetchMaterials(params);
  }
}
