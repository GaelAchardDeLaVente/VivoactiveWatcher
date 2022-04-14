part of 'steps_bloc.dart';

abstract class StepsState extends Equatable {
  const StepsState();
}

class StepsInitial extends StepsState {
  @override
  List<Object> get props => [];
}

class StepsLoading extends StepsState {
  @override
  List<Object> get props => [];
}

class StepsLoaded extends StepsState {
  final List<StepData> steps;

  const StepsLoaded(this.steps) : super();

  @override
  List<Object> get props => [steps];
}
