import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/core/domain/entities/common_response_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/login_usecase.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/accyearResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/feeExistCheckResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/feeProcessingResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/feeSaveResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paid_fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paymentGatewayDetails.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/unpaid%20fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/feePayExistRequest.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/offlinePaymentSaveRequest.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paymentSaveRequest.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/checkFeePayExistUseCase.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/fetchAccYearUseCase.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/fetchFeeProcessingListUseCase.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/fetchPaidFeesDetailsUseCase.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/fetchPaymentGatewayDetailsUseCase.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/fetchUnpaidFeeDetailsUseCase.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/saveFeePaymentUseCase.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/saveOfflineFeeDetailsUseCase.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

part 'fees_state.dart';

class FeesCubit extends Cubit<FeesState> {
  final FetchPaidFeesDetailsUseCase _fetchPaidFeesDetailsUseCase;
  final FetchAccYearListUseCase _fetchAccYearListUseCase;
  final FetchUnPaidFeesDetailsUseCase _fetchUnPaidFeesDetailsUseCase;
  final SaveFeesDetailsUseCase _saveFeesDetailsUseCase;
  final SaveOfflineFeesDetailsUseCase _saveOfflineFeesDetailsUseCase;
  final LoginServerUseCase _loginUseCase;
  final CheckFeeExistUseCase _checkFeeExistUseCase;
  final FetchPaidFeeProcessingListUseCase _feeProcessingListUseCase;


  FeesCubit({
    required LoginServerUseCase loginServerUseCase,
    required FetchPaidFeesDetailsUseCase fetchPaidFeesDetailsUseCase,
    required FetchAccYearListUseCase fetchAccYearListUseCase,
    required FetchUnPaidFeesDetailsUseCase fetchUnPaidFeesDetailsUseCase,
    required SaveFeesDetailsUseCase saveFeesDetailsUseCase,
    required SaveOfflineFeesDetailsUseCase saveOfflineFeesDetailsUseCase,
    required CheckFeeExistUseCase checkFeeExistUseCase,
    required FetchPaidFeeProcessingListUseCase feeProcessingListUseCase,
  }) : _loginUseCase = loginServerUseCase,
        _fetchPaidFeesDetailsUseCase = fetchPaidFeesDetailsUseCase,
       _fetchAccYearListUseCase = fetchAccYearListUseCase,
       _fetchUnPaidFeesDetailsUseCase = fetchUnPaidFeesDetailsUseCase,
       _saveFeesDetailsUseCase = saveFeesDetailsUseCase,
        _saveOfflineFeesDetailsUseCase = saveOfflineFeesDetailsUseCase,
        _checkFeeExistUseCase = checkFeeExistUseCase,
        _feeProcessingListUseCase = feeProcessingListUseCase,

       super(FeesInitial());

  Future<void> checkFeeExist(FeePaymentExistRequest request) async {
    print('FeePaymentExistRequest ${request.toJson()}');
    emit(FeeSaveCheckLoading());
    try {
      final result = await _checkFeeExistUseCase(request);

      result.fold(
            (failure) {
          print('failure ${failure.message}');
          emit(FeeCheckFailure(failure.message));
        },
            (response) async {

          emit(CheckFeeStatusSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(FeeCheckFailure('An unexpected error occurred'));
    }
  }

  Future<void> loginCheckForFeeCollectionStatus(LoginRequest loginRequest) async {
    print('loginRequest ${loginRequest.toJson()}');
    emit(FeeCollectionCheckLoading());
    try {
      final result = await _loginUseCase(loginRequest);

      result.fold(
            (failure) {
          print('failure ${failure.message}');
          emit(LoginCheckFailure(failure.message));
        },
            (loginResponse) async {
          final sharedPrefHelper = SharedPreferenceHelper();
          await sharedPrefHelper.saveClassAndDivision(
            loginResponse.student!.studentStandard +
                '-' +
                loginResponse.student!.studentDivision,
          );
          AppData.studentClass =
              '${loginResponse.student!.studentStandard}-${loginResponse.student!.studentDivision}'
                  .toString();
          AppData.profileUrl = loginResponse.student!.imageUrl.toString();
          emit(LoginCheckSuccess(loginResponse));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(LoginCheckFailure('An unexpected error occurred'));
    }
  }

  Future<void> fetchUnPaidFeeDetails(PaidFeesRequest request) async {
    print('PaidFeesRequest ${request.toJson()}');
    emit(FeeUnpaid_Loading());
    try {
      final result = await _fetchUnPaidFeesDetailsUseCase(request);

      result.fold(
        (failure) {
          emit(FeeUnPaid_Failure(failure.message));
        },
        (response) {
          emit(FeesUnPaid_Success(response));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(FeeUnPaid_Failure('An unexpected error occurred'));
    }
  }

  Future<void> fetchPaidFeesDetails(PaidFeesRequest request) async {
    print('PaidFeesRequest ${request.toJson()}');

    emit(FeesPaidLoading());
    try {
      final result = await _fetchPaidFeesDetailsUseCase(request);

      result.fold(
        (failure) {
          emit(FeesPaidFailure(failure.message));
        },
        (loginResponse) {
          emit(FeesPaidSuccess(loginResponse));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(FeesPaidFailure('An unexpected error occurred'));
    }
  }

  Future<void> fetchAccYearList() async {

    emit(AccYearsInitial());
    try {
      final result = await _fetchAccYearListUseCase();

      result.fold(
        (failure) {
          emit(AccYearFailure(failure.message));
        },
        (accYearResponse) {
          emit(AccYearSuccess(accYearResponse));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(FeesPaidFailure('An unexpected error occurred'));
    }
  }

  Future<void> saveFeeDetails(FeeSaveRequest request) async {
    print('SaveFeesRequest ${request.toJson()}');
    emit(FeeSave_Loading());
    try {
      final result = await _saveFeesDetailsUseCase(request);

      result.fold(
        (failure) {
          emit(SaveFees_Failure(failure.message));
        },
        (response) {
          emit(FeeSave_Success(response));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(SaveFees_Failure('An unexpected error occurred'));
    }
  }

  Future<void> saveOfflineFeeDetails(OfflineFeePayRequest request) async {
    print('SaveOfflineFeesRequest ${request.toJson()}');
    emit(FeeSave_Loading());
    try {
      final result = await _saveOfflineFeesDetailsUseCase(request);

      result.fold(
            (failure) {
          emit(SaveFees_Failure(failure.message));
        },
            (response) {
          emit(FeeSave_Success(response));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(SaveFees_Failure('An unexpected error occurred'));
    }
  }

  Future<void> fetchProcessingFeeDetails(PaidFeesRequest request) async {
    print('PaidFeesRequest ${request.toJson()}');
    emit(FeeProcessingFeeListLoading());
    try {
      final result = await _feeProcessingListUseCase(request);

      result.fold(
            (failure) {
          emit(FeeProcessingFeeListFailure(failure.message));
        },
            (response) {
          emit(FeeProcessingFeeSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      // Handle unexpected exceptions
      print('❌ Exception during loginUser: $e');
      print('Stacktrace: $stacktrace');
      emit(FeeProcessingFeeListFailure('An unexpected error occurred'));
    }
  }


}
