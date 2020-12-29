import 'package:hooks_riverpod/all.dart';
import 'package:meta/meta.dart';
import 'package:yaxxxta/habit/domain/db.dart';
import 'package:yaxxxta/habit/domain/models.dart';
import 'package:yaxxxta/settings/domain/models.dart';
import '../../../core/utils/dt.dart';

class HabitPerformingController {
  final BaseHabitPerformingRepo habitPerformingRepo;
  final StateController<List<HabitPerforming>> todayHabitPerformingsState;
  final StateController<List<HabitPerforming>> dateHabitPerformingsState;
  final Settings settings;

  HabitPerformingController({
    @required this.habitPerformingRepo,
    @required this.todayHabitPerformingsState,
    @required this.dateHabitPerformingsState,
    @required this.settings,
  });

  Future<void> create({
    @required int habitId,
    @required int repeatIndex,
    double performValue = 1,
    DateTime performDateTime,
  }) async {
    performDateTime = performDateTime ?? DateTime.now();

    var performing = HabitPerforming(
      habitId: habitId,
      repeatIndex: repeatIndex,
      performValue: performValue,
      performDateTime: performDateTime,
    );
    await habitPerformingRepo.insert(performing);

    var stateController = getDateState(performDateTime);
    stateController.state = [...stateController.state, performing];
  }

  void load(DateTime date) {
    var dateStart = buildDateTime(date, settings.dayStartTime);
    var dateEnd = buildDateTime(date, settings.dayEndTime);
    var performings = habitPerformingRepo.list(dateStart, dateEnd);
    getDateState(date).state = performings;
  }

  StateController<List<HabitPerforming>> getDateState(DateTime date) =>
      date.isToday() ? todayHabitPerformingsState : dateHabitPerformingsState;
}
