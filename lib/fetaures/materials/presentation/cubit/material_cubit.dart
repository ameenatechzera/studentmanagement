import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/fetaures/materials/data/models/fetch_materials_model.dart';
import 'package:studentmanagement/fetaures/materials/data/models/subjects_model.dart';
import 'package:studentmanagement/fetaures/materials/domain/entities/fetch_material_entity.dart';
import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_material_parameter.dart';
import 'package:studentmanagement/fetaures/materials/domain/usecases/fetch_materials_usecase.dart';
import 'package:studentmanagement/fetaures/materials/domain/usecases/fetch_subjects_usecase.dart';

part 'material_state.dart';

class MaterialCubit extends Cubit<MaterialsState> {
  final FetchMaterialUseCase fetchMaterialUseCase;
  final FetchSubjectsUseCase fetchSubjectsUseCase;

  MaterialCubit({required this.fetchMaterialUseCase , required this.fetchSubjectsUseCase})
    : super(MaterialInitial());

  Future<void> fetchMaterials(FetchMaterialParameter params) async {
    emit(MaterialLoading());

    final result = await fetchMaterialUseCase(params);

    result.fold(
      (failure) {
        emit(MaterialError(message: failure.message));
      },
      (response) {
        emit(MaterialLoaded(response: response.data!));
      },
    );
  }

  Future<void> fetchSubjects() async {
    emit(SubjectsLoading());

    final result = await fetchSubjectsUseCase();

    result.fold(
          (failure) {
        emit(SubjectsError(message: failure.message));
      },
          (response) {
        emit(SubjectsLoaded(response: response));
      },
    );
  }
}
