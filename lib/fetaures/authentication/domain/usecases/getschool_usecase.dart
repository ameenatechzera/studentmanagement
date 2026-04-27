import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/getschool_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/fetchschool_parameter.dart';
import 'package:studentmanagement/fetaures/authentication/domain/repositories/auth_repository.dart';

class FetchSchoolUseCase
    implements UseCaseWithParams<FetchSchoolEntity, FetchSchoolRequest> {
  final AuthRepository _authRepository;

  FetchSchoolUseCase(this._authRepository);

  @override
  ResultFuture<FetchSchoolEntity> call(FetchSchoolRequest request) async {
    return _authRepository.fetchSchools(request);
  }
}
