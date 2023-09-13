import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/failures/failures.dart';
import '../../../../domain/usecases/advice_usecases.dart';

part 'advicer_state.dart';

const generalFailureMessage = "Ups, something gone wrong. Please try again";
const cacheFailureMessage = "Ups, cache failed. Please try again!";
const serverFailureMessage = "Ups, API error, please try again!";

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  final AdviceUseCases adviceUseCases;

  AdvicerCubit({required this.adviceUseCases}) : super(AdvicerInitial());
  
  void adviceRequested() async {
    emit(AdvicerStateLoading());
    final failureOrAdvice = await adviceUseCases.getAdvice();
    failureOrAdvice.fold(
        (failure) =>
            emit(AdvicerStateError(message: _mapFailureToMessage(failure))),
        (advice) => emit(AdvicerStateLoaded(advice: advice.advice)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
