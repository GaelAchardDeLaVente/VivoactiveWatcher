// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StepDataEntity extends Equatable {
  final String id;
  final DateTime date;
  final int stepsNumber;

  const StepDataEntity(this.id, this.date, this.stepsNumber);

  @override
  List<Object?> get props => [
        id,
        date,
        stepsNumber,
      ];

  @override
  String toString() {
    return 'StepData date : $date, stepsNumber : $stepsNumber';
  }

  static StepDataEntity fromSnapshot(DocumentSnapshot snap) {
    return StepDataEntity(
      snap.id,
      (snap.data() as dynamic)['date'].toDate(),
      (snap.data() as dynamic)['stepsNumber'],
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'date': date,
      'stepsNumber': stepsNumber,
    };
  }
}
