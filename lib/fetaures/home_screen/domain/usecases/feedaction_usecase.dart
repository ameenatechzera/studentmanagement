import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/feedaction_model.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/feedaction_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/repositories/feed_repository.dart';

class FeedActionUseCase
    implements UseCaseWithParams<FeedActionResponseModel, FeedActionParameter> {
  final FeedRepository _feedRepository;

  FeedActionUseCase(this._feedRepository);

  @override
  ResultFuture<FeedActionResponseModel> call(FeedActionParameter params) async {
    return _feedRepository.feedAction(params);
  }
}
