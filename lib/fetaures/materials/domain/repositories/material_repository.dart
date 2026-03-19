import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/materials/data/models/fetch_materials_model.dart';
import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_material_parameter.dart';

abstract class MaterialRepository {
  ResultFuture<FetchMaterialResponseModel> fetchMaterials(
    FetchMaterialParameter params,
  );
}
