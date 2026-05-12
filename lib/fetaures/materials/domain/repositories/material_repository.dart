import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/materials/data/models/fetch_materials_model.dart';
import 'package:studentmanagement/fetaures/materials/data/models/fetch_materialsbysubject_model.dart';
import 'package:studentmanagement/fetaures/materials/data/models/subjects_model.dart';
import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_material_parameter.dart';
import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_materialsbysubjectId.dart';

abstract class MaterialRepository {
  ResultFuture<FetchMaterialResponseModel> fetchMaterials(
    FetchMaterialParameter params,
  );
  ResultFuture<FetchMaterialsbySubjectModel> fetchMaterialsBySubjectId(
      FetchMaterialBySubjectIdParameter params,
      );
  ResultFuture<SubjectsModel> fetchSubjects();

}
