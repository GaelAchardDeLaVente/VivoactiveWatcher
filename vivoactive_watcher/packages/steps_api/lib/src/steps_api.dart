import '../steps_api.dart';

/// {@template todos_api}
/// The interface for an API that provides access to a list of todos.
/// {@endtemplate}
abstract class StepsApi {
  /// {@macro todos_api}
  const StepsApi();

  /// Provides a [Stream] of all users.
  Stream<List<StepData>> getSteps();
}

class UserNotFoundException implements Exception {}
