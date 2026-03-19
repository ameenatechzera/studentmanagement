import 'package:dartz/dartz.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/errors/failure.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/materials/data/datasources/materials_remote_data_source.dart';
import 'package:studentmanagement/fetaures/materials/data/models/fetch_materials_model.dart';
import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_material_parameter.dart';
import 'package:studentmanagement/fetaures/materials/domain/repositories/material_repository.dart';

class MaterialRepositoryImpl implements MaterialRepository {
  final MaterialRemoteDataSource _remoteDataSource;

  MaterialRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<FetchMaterialResponseModel> fetchMaterials(
    FetchMaterialParameter params,
  ) async {
    try {
      final result = await _remoteDataSource.fetchMaterials(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
