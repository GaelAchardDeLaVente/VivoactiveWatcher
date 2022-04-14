import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steps_api/steps_api.dart';

class FirebaseStepsApi extends StepsApi {
  final stepsCollection = FirebaseFirestore.instance.collection('weekSteps');

  // gets a stream of the coach's events collection from firebase
  // @param coachID: the coach's document ID
  @override
  Stream<List<StepData>> getSteps() {
    return stepsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => StepData.fromEntity(StepDataEntity.fromSnapshot(doc)))
          .toList();
    });
  }
  //
  // @override
  // Future<void> createUser(StepData user) async {
  //   await usersCollection.add(user.toEntity().toDocument());
  // }
  //
  // @override
  // Future<void> updateUser(StepData user) async {
  //   await usersCollection.doc(user.id).set(user.toEntity().toDocument());
  // }
  //
  // @override
  // Future<String?> uploadFile(String userID, Uint8List file) async {
  //   // File file = File(filePath);
  //   String time = DateTime.now().millisecondsSinceEpoch.toString();
  //   String imagePath = 'podoAnlysis-$userID-$time.jpeg';
  //
  //   String downloadUrl;
  //
  //   firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
  //       .ref('photos')
  //       .child(imagePath)
  //       .putData(
  //         file,
  //         firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
  //       );
  //
  //   try {
  //     // Storage tasks function as a Delegating Future so we can await them.
  //     firebase_storage.TaskSnapshot snapshot = await task;
  //     downloadUrl = await downloadUrlImageAvatar(imagePath: imagePath);
  //     return downloadUrl;
  //   } on firebase_core.FirebaseException catch (e) {
  //     // The final snapshot is also available on the task via `.snapshot`,
  //     // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
  //     print(task.snapshot);
  //     print(e);
  //     if (e.code == 'permission-denied') {
  //       print('User does not have permission to upload to this reference.');
  //     }
  //     return null;
  //   }
  // }
  //
  // Future<String> downloadUrlImageAvatar({required String imagePath}) async {
  //   String downloadURL = await firebase_storage.FirebaseStorage.instance
  //       .ref('photos')
  //       .child(imagePath)
  //       .getDownloadURL();
  //   return downloadURL;
  // }
  //
  // @override
  // Stream<List<Shift>> getShifts() {
  //   return shiftManagementCollection.snapshots().map((snapshot) {
  //     return snapshot.docs
  //         .map((doc) => Shift.fromEntity(ShiftEntity.fromSnapshot(doc)))
  //         .toList();
  //   });
  // }
  //
  // @override
  // Future<String?> getDownloadUrl(String imagePath) {
  //   // TODO: implement getDownloadUrl
  //   throw UnimplementedError();
  // }
}
