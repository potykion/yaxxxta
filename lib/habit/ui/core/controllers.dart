import 'package:hooks_riverpod/all.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/dt.dart';
import '../../../settings/domain/models.dart';
import '../../domain/db.dart';
import '../../domain/models.dart';

/// Контроллер выполнений привычек
class HabitPerformingController {
  /// Репо выполнений привычек
  final BaseHabitPerformingRepo habitPerformingRepo;

  /// Состояние загрузки
  final StateController<bool> loadingState;

  /// Состояние выполнений привычек за сегодня
  final StateController<List<HabitPerforming>> todayHabitPerformingsState;

  /// Состояние выполнений привычек за дату
  final StateController<List<HabitPerforming>> dateHabitPerformingsState;

  /// Настроечки
  final Settings settings;

  /// Контроллер выполнений привычек
  HabitPerformingController({
    @required this.habitPerformingRepo,
    @required this.todayHabitPerformingsState,
    @required this.dateHabitPerformingsState,
    @required this.settings,
    @required this.loadingState,
  });

  /// Создает выполнение привычки, обновляя состояние
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

  /// Загружает выполнения привычек за дату, обновляя состояние
  void load(DateTime date) async {
    loadingState.state = true;
    var dateStart = buildDateTime(date, settings.dayStartTime);
    var dateEnd = buildDateTime(date, settings.dayEndTime);
    var performings = habitPerformingRepo.list(dateStart, dateEnd);
    getDateState(date).state = performings;
    loadingState.state = false;
  }

  /// Получает состояние выполнений привычек за дату
  StateController<List<HabitPerforming>> getDateState(DateTime date) =>
      date.isToday() ? todayHabitPerformingsState : dateHabitPerformingsState;
}
