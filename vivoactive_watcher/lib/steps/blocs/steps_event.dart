part of 'steps_bloc.dart';

abstract class StepsEvent extends Equatable {
  const StepsEvent();

  @override
  List<Object> get props => [];
}

class LoadSteps extends StepsEvent {
  const LoadSteps();

  @override
  List<Object> get props => [];
}

class StepsLoad extends StepsEvent {
  final List<StepData> stepData;

  const StepsLoad(this.stepData);

  @override
  List<Object> get props => [stepData];
}
