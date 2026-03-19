part of 'material_cubit.dart';

abstract class MaterialsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MaterialInitial extends MaterialsState {}

class MaterialLoading extends MaterialsState {}

class MaterialLoaded extends MaterialsState {
  final FetchMaterialResponseModel response;

  MaterialLoaded({required this.response});

  @override
  List<Object?> get props => [response];
}

class MaterialError extends MaterialsState {
  final String message;

  MaterialError({required this.message});

  @override
  List<Object?> get props => [message];
}
