import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steps_api/steps_api.dart';

class FirebaseStepsApi extends StepsApi {
  final stepsCollection = FirebaseFirestore.instance.collection('weekSteps');

  // gets a stream of the weekSteps collection from firebase
  @override
  Stream<List<StepData>> getSteps() {
    return stepsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => StepData.fromEntity(StepDataEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
