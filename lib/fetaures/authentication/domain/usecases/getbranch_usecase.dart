import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/getbranch_entitiy.dart';
import 'package:studentmanagement/fetaures/authentication/domain/repositories/auth_repository.dart';

class GetBranchUseCase implements UseCaseWithoutParams<GetBranchEntity> {
  final AuthRepository _authRepository;

  GetBranchUseCase(this._authRepository);

  @override
  ResultFuture<GetBranchEntity> call() async {
    return _authRepository.getBranchDetails();
  }
}
