import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paid_fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/unpaid%20fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';

abstract class FeesRepository {
  ResultFuture<PaidFeeResult> fetchPaidFees(PaidFeesRequest request);
  ResultFuture<UnpaidFeeResult> fetchUnPaidFees(PaidFeesRequest request);
}
