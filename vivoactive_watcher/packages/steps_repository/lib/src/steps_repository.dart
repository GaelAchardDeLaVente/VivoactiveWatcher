import 'package:steps_api/steps_api.dart';

/// A repository that handles steps related requests.
class StepsRepository {
  const StepsRepository({
    required StepsApi stepsApi,
  }) : _stepsApi = stepsApi;

  final StepsApi _stepsApi;

  /// Provides a [Stream] of all steps.
  Stream<List<StepData>> getSteps() => _stepsApi.getSteps();
}
