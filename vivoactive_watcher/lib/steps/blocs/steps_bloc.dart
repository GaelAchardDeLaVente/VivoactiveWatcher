import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:steps_repository/steps_repository.dart';

part 'steps_event.dart';
part 'steps_state.dart';

class StepsBloc extends Bloc<StepsEvent, StepsState> {
  final StepsRepository _stepsRepository;

  StepsBloc({required StepsRepository stepsRepository})
      : _stepsRepository = stepsRepository,
        super(StepsInitial()) {
    on<LoadSteps>(_onLoadStepsRequested);
    on<StepsLoad>(_onStepsLoadRequested);
  }

  StreamSubscription<List<StepData>>? _stepDataSubscription;

  void _onLoadStepsRequested(LoadSteps event, Emitter<StepsState> emit) async {
    emit(StepsLoading());
    _stepDataSubscription?.cancel();
    _stepDataSubscription =
        _stepsRepository.getSteps().listen((steps) => add(StepsLoad(steps)));
  }

  void _onStepsLoadRequested(StepsLoad event, Emitter<StepsState> emit) async {
    emit(StepsLoaded(getWeekStepData(event.stepData)));
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return DateTime.parse(DateFormat("yyyy-MM-dd 00:00:00.000")
        .format(dateTime.subtract(Duration(days: dateTime.weekday - 1))));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return DateTime.parse(DateFormat("yyyy-MM-dd 23:59:59.999").format(
        dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday))));
  }

  List<StepData> getWeekStepData(List<StepData> stepData) {
    List<StepData> weekStepData = stepData
        .where((element) =>
            element.date.isBefore(findLastDateOfTheWeek(DateTime.now())) &&
            element.date.isAfter(findFirstDateOfTheWeek(DateTime.now())))
        .toList();
    weekStepData.sort((a, b) => a.date.compareTo(b.date));
    return weekStepData;
  }
}
