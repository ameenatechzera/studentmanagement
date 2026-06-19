import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/errors/failure.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/home_screen/data/datasources/feed_remote_data_source.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/feedaction_model.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/fetchfeed_model.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/feedaction_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/repositories/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;
  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<FetchFeedResponseModel> fetchFeeds(
    FetchFeedParameter params,
  ) async {
    try {
      final result = await remoteDataSource.fetchFeeds(params);
      log("========== FEED API SUCCESS ==========");
      log("Total feeds from API: ${result.data?.length ?? 0}");

      if ((result.data?.isNotEmpty ?? false)) {
        log("First Feed ID: ${result.data!.first.feedId}");
        log("First Feed Text: ${result.data!.first.feedText}");
      }

      return Right(result);
    } on ServerException catch (e) {
      log("SERVER EXCEPTION: ${e.errorMessageModel.statusMessage}");
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<FeedActionResponseModel> feedAction(
    FeedActionParameter params,
  ) async {
    try {
      final result = await remoteDataSource.feedAction(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
