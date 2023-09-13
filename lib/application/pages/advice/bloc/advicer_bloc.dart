import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  AdvicerBloc() : super(AdvicerInitial()) {
    on<AdviceRequestEvent>((event, emit) async {
      emit(AdvicerStateLoading());
      debugPrint("fake get advice triggered");
      await Future.delayed(Duration(seconds: 3), () {});
      debugPrint("got advice");
      emit(AdvicerStateLoaded(advice: "Fake advice to test bloc"));
      //emit(AdvicerStateError(messaage: "error message"));
    });
  }
}
