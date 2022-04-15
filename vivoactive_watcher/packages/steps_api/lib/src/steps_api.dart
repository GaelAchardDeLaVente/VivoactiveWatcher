import '../steps_api.dart';

/// The interface for an API that provides access to a list of steps.
abstract class StepsApi {
  const StepsApi();

  /// Provides a [Stream] of all steps.
  Stream<List<StepData>> getSteps();
}

class UserNotFoundException implements Exception {}
