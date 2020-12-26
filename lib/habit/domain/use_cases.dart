import 'package:meta/meta.dart';

import 'db.dart';
import 'models.dart';

class CreatePerforming {
  final BaseHabitPerformingRepo habitPerformingRepo;

  CreatePerforming({this.habitPerformingRepo});

  Future<HabitPerforming> call({
    @required int habitId,
    @required int repeatIndex,
    double performValue,
    DateTime performDateTime,
  }) async {
    var performing = HabitPerforming(
      habitId: habitId,
      repeatIndex: repeatIndex,
      performValue: performValue ?? 1,
      performDateTime: performDateTime ?? DateTime.now(),
    );
    await habitPerformingRepo.insert(performing);
    return performing;
  }
}
