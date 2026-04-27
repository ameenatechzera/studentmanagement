import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/feedaction_model.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/fetchfeed_model.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/feedaction_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';

abstract class FeedRepository {
  ResultFuture<FetchFeedResponseModel> fetchFeeds(FetchFeedParameter params);

  ResultFuture<FeedActionResponseModel> feedAction(FeedActionParameter params);
}
