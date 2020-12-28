import 'package:meta/meta.dart';
import 'package:yaxxxta/core/utils/dt.dart';
import 'package:yaxxxta/settings/domain/models.dart';

import 'db.dart';
import 'models.dart';

class CreateHabitPerforming {
  final BaseHabitPerformingRepo habitPerformingRepo;

  CreateHabitPerforming({this.habitPerformingRepo});

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

class LoadDateHabitPerformings {
  final Settings settings;
  final BaseHabitPerformingRepo habitPerformingRepo;

  LoadDateHabitPerformings({this.habitPerformingRepo, this.settings});

  List<HabitPerforming> call(DateTime date) {
    var dateStart = buildDateTime(date, settings.dayStartTime);
    var dateEnd = buildDateTime(date, settings.dayEndTime);
    return habitPerformingRepo.list(dateStart, dateEnd);
  }
}
