import 'package:device_info/device_info.dart';
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
  /// TODO удалить create, использовать HabitPerforming.blank
  Future<void> create({
    @required String habitId,
    double performValue = 1,
    DateTime performDateTime,
  }) =>
      insert(
        HabitPerforming(
          habitId: habitId,
          performValue: performValue,
          performDateTime: performDateTime ?? DateTime.now(),
        ),
      );

  /// Вставляет выполнение привычки и обновляет состояние
  Future<void> insert(HabitPerforming habitPerforming) async {
    habitPerforming = habitPerforming.copyWith(
      id: await habitPerformingRepo.insert(habitPerforming),
    );
    var stateController = getDateState(habitPerforming.performDateTime);
    stateController.state = [
      ...stateController.state,
      habitPerforming,
    ];
  }

  /// Загружает выполнения привычек за дату, обновляя состояние
  Future<void> load(DateTime date) async {
    loadingState.state = true;

    var dateRange = DateRange.fromDateAndTimes(
      date,
      settings.dayStartTime,
      settings.dayEndTime,
    );

    /// Если дата сегодняшняя, и текущее время не входит в дейт ренж даты =>
    /// берем дейт ренж за предыдущую дату
    if (date.isToday() && !dateRange.containsDateTime(DateTime.now())) {
      dateRange = DateRange.fromDateAndTimes(
        date.add(Duration(days: -1)),
        settings.dayStartTime,
        settings.dayEndTime,
      );
    }
    var performings =
        await habitPerformingRepo.list(dateRange.from, dateRange.to);
    getDateState(date).state = performings;
    loadingState.state = false;
  }

  /// Получает состояние выполнений привычек за дату
  StateController<List<HabitPerforming>> getDateState(DateTime date) =>
      date.isToday() ? todayHabitPerformingsState : dateHabitPerformingsState;

  Future<void> deleteForDateTime(DateTime dateTime) async {
    var dateRange = DateRange.withinMinute(dateTime);
    await habitPerformingRepo.delete(dateRange.from, dateRange.to);
    var state = getDateState(dateTime);
    state.state = state.state
        .where((hp) => !dateRange.containsDateTime(hp.performDateTime))
        .toList();
  }

  /// Обновление выполнения привычки: удаление привычек в пределах минуты +
  /// вставка выполнения привычки
  Future<void> update(HabitPerforming habitPerforming) async {
    await deleteForDateTime(habitPerforming.performDateTime);
    await insert(habitPerforming);
  }
}

/// Контроллер привычек
class HabitController {
  /// Репо привычек
  final BaseHabitRepo habitRepo;

  /// Стейт привычек
  final StateController<List<Habit>> habitState;

  /// Инфа о ведре
  final AndroidDeviceInfo deviceInfo;

  /// Контроллер привычек
  HabitController({
    @required this.habitRepo,
    @required this.habitState,
    @required this.deviceInfo,
  });

  /// Грузит список привычек и сеттит в стейт
  Future<void> list() async {
    habitState.state = await habitRepo.list();
  }

  /// Удаляет привычку
  Future<void> delete(String habitId) async {
    await habitRepo.delete(habitId);
    habitState.state = [...habitState.state.where((h) => h.id != habitId)];
  }

  /// Создает или обновляет привычку в зависимости от наличия айди
  Future<Habit> createOrUpdateHabit(Habit habit) async {
    if (habit.deviceId == null) {
      habit = habit.copyWith(deviceId: deviceInfo.id);
    }

    if (habit.isUpdate) {
      await habitRepo.update(habit);
      habitState.state = [
        for (var h in habitState.state)
          if (h.id == habit.id) habit else h
      ];
    } else {
      habit = habit.copyWith(id: await habitRepo.insert(habit));
      habitState.state = [...habitState.state, habit];
    }

    return habit;
  }
}
