import 'package:steps_api/steps_api.dart';

/// A repository that handles user related requests.

class StepsRepository {
  /// {@macro todos_repository}
  const StepsRepository({
    required StepsApi stepsApi,
  }) : _stepsApi = stepsApi;

  final StepsApi _stepsApi;

  /// Provides a [Stream] of all users.
  Stream<List<StepData>> getSteps() => _stepsApi.getSteps();
}
