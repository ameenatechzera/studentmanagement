import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/marklist/data/models/fetch_examterm_model.dart';
import 'package:studentmanagement/fetaures/marklist/data/models/fetch_marklist_model.dart';
import 'package:studentmanagement/fetaures/marklist/domain/parameter/fetch_marklist_parameter.dart';

abstract class MarkListRepository {
  ResultFuture<FetchExamTermResponseModel> fetchExamTerms();
  ResultFuture<FetchMarkListResponseModel> fetchMarkList(
    FetchMarkListParameter params,
  );
}
