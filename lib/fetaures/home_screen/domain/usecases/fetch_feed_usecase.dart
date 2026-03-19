import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/fetchfeed_model.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/repositories/feed_repository.dart';

class FetchFeedUseCase
    implements UseCaseWithParams<FetchFeedResponseModel, FetchFeedParameter> {
  final FeedRepository _feedRepository;

  FetchFeedUseCase(this._feedRepository);

  @override
  ResultFuture<FetchFeedResponseModel> call(FetchFeedParameter params) async {
    return _feedRepository.fetchFeeds(params);
  }
}
