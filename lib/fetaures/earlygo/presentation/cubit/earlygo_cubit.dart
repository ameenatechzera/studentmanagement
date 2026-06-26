import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/core/data/models/common_response_model.dart';
import 'package:studentmanagement/fetaures/earlygo/data/models/fetch_earlygorequest_model.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/parameters/save_earlyleave_parameter.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/usecases/fetch_earlygorequest_usecase.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/usecases/save_earlygo_usecase.dart';
part 'earlygo_state.dart';

class EarlygoCubit extends Cubit<EarlygoState> {
  final FetchEarlyLeaveUseCase fetchEarlyLeaveUseCase;
  final SaveEarlyLeaveUseCase saveEarlyLeaveUseCase;

  EarlygoCubit({
    required this.fetchEarlyLeaveUseCase,
    required this.saveEarlyLeaveUseCase,
  }) : super(EarlygoInitial());

  Future<void> fetchEarlyLeave() async {
    emit(EarlyLeaveLoading());

    final result = await fetchEarlyLeaveUseCase();

    result.fold(
      (failure) {
        emit(EarlyLeaveError(message: failure.message));
      },
      (response) {
        emit(EarlyLeaveLoaded(response: response));
      },
    );
  }

  // /// Save Early Leave Request
  // Future<void> saveEarlyLeave(SaveEarlyLeaveParameter params) async {
  //   emit(SaveEarlyLeaveLoading());

  //   final result = await saveEarlyLeaveUseCase(params);

  //   result.fold(
  //     (failure) {
  //       emit(SaveEarlyLeaveError(message: failure.message));
  //     },
  //     (CommonResponseModel response) {
  //       emit(SaveEarlyLeaveSuccess(response: response));
  //     },
  //   );
  // }
  Future<void> saveEarlyLeave(SaveEarlyLeaveParameter params) async {
    print("saveEarlyLeaveUseCase => $saveEarlyLeaveUseCase");
    print('SaveEarlyLeaveParameter ${params.toJson()}');

    emit(SaveEarlyLeaveLoading());

    final result = await saveEarlyLeaveUseCase(params);

    result.fold(
      (failure) {
        emit(SaveEarlyLeaveError(message: failure.message));
      },
      (response) {
        emit(SaveEarlyLeaveSuccess(response: response));
      },
    );
  }
}
