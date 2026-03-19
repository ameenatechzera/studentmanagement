import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/fetaures/materials/data/models/fetch_materials_model.dart';
import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_material_parameter.dart';
import 'package:studentmanagement/fetaures/materials/domain/usecases/fetch_materials_usecase.dart';

part 'material_state.dart';

class MaterialCubit extends Cubit<MaterialsState> {
  final FetchMaterialUseCase fetchMaterialUseCase;

  MaterialCubit({required this.fetchMaterialUseCase})
    : super(MaterialInitial());

  Future<void> fetchMaterials(FetchMaterialParameter params) async {
    emit(MaterialLoading());

    final result = await fetchMaterialUseCase(params);

    result.fold(
      (failure) {
        emit(MaterialError(message: failure.message));
      },
      (response) {
        emit(MaterialLoaded(response: response));
      },
    );
  }
}
