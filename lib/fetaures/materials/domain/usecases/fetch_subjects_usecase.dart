import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/materials/data/models/fetch_materials_model.dart';
import 'package:studentmanagement/fetaures/materials/data/models/subjects_model.dart';
import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_material_parameter.dart';
import 'package:studentmanagement/fetaures/materials/domain/repositories/material_repository.dart';

class FetchSubjectsUseCase
    implements
        UseCaseWithoutParams<SubjectsModel> {
  final MaterialRepository _materialRepository;

  FetchSubjectsUseCase(this._materialRepository);

  @override
  ResultFuture<SubjectsModel> call(
      ) async {
    return _materialRepository.fetchSubjects();
  }
}
