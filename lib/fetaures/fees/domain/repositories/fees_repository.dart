import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/accyearResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/feeSaveResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paid_fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/unpaid%20fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paymentSaveRequest.dart';

abstract class FeesRepository {
  ResultFuture<PaidFeeResult> fetchPaidFees(PaidFeesRequest request);
  ResultFuture<UnpaidFeeResult> fetchUnPaidFees(PaidFeesRequest request);
  ResultFuture<AccYearResult> fetchAccYearsList();
  ResultFuture<FeeSaveResult> saveFeesDetails(FeeSaveRequest request);

}
