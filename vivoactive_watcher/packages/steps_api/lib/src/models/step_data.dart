import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class StepData extends Equatable {
  final String id;
  final DateTime date;
  final int stepsNumber;

  StepData({required this.id, required this.date, required this.stepsNumber});

  @override
  String toString() {
    return 'id $id '
        'StepData date : $date, stepsNumber : $stepsNumber';
  }

  @override
  List<Object> get props => [
        id,
        date,
        stepsNumber,
      ];

  StepDataEntity toEntity() {
    return StepDataEntity(
      id,
      date,
      stepsNumber,
    );
  }

  static StepData fromEntity(StepDataEntity entity) {
    return StepData(
      id: entity.id,
      date: entity.date,
      stepsNumber: entity.stepsNumber,
    );
  }
}
