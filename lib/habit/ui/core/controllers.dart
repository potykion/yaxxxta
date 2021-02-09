import 'package:device_info/device_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/dt.dart';
import '../../../settings/domain/models.dart';
import '../../domain/db.dart';
import '../../domain/models.dart';
import '../../../core/utils/list.dart';

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

class HabitPerformingController
    extends StateNotifier<Map<DateTime, List<HabitPerforming>>> {
  final Settings settings;
  final BaseHabitPerformingRepo repo;

  HabitPerformingController({
    this.repo,
    this.settings,
    Map<DateTime, List<HabitPerforming>> state = const {},
  }) : super(state);

  Future<void> loadDateHabitPerformings(DateTime date) async {
    date = date.date();

    var dateRange = DateRange.fromDateAndTimes(
      date,
      settings.dayStartTime,
      settings.dayEndTime,
    );

    var newState = Map.of(state);
    newState[date] = <HabitPerforming>[
      ...(newState[date] ?? []),
      ...await repo.list(dateRange.from, dateRange.to)
    ].distinctBy((item) => item.id);

    state = newState;

  }

  Future<void> loadSelectedHabitPerformings(String habitId) async {

    var performings = await repo.listByHabit(habitId);

    var datePerformings = groupBy<HabitPerforming, DateTime>(
      performings,
      (hp) => DateRange.fromDateTimeAndTimes(
        hp.performDateTime,
        settings.dayStartTime,
        settings.dayEndTime,
      ).date,
    );

    var newState = Map.of(state);
    for (var dateAndPerformings in datePerformings.entries) {
      newState[dateAndPerformings.key] = <HabitPerforming>[
        ...(newState[dateAndPerformings.key] ?? []),
        ...dateAndPerformings.value
      ].distinctBy((item) => item.id);
    }

    state = newState;

  }

  DateTime _dateFromDateTime(DateTime dateTime) =>
      DateRange.fromDateTimeAndTimes(
        dateTime,
        settings.dayStartTime,
        settings.dayEndTime,
      ).date;

  Future<void> insert(HabitPerforming hp) async {
    hp = hp.copyWith(id: await repo.insert(hp));

    var newState = Map.of(state);
    var date = _dateFromDateTime(hp.performDateTime);
    newState[date] = [...(newState[date] ?? []), hp];

    state = newState;
  }

  Future<void> deleteForDateTime(DateTime dateTime) async {
    var dateRange = DateRange.withinMinute(dateTime);
    await repo.delete(dateRange.from, dateRange.to);
    var date = _dateFromDateTime(dateTime);

    var newState = Map.of(state);
    newState[date] = (newState[date] ?? <HabitPerforming>[])
        .where((hp) => !dateRange.containsDateTime(hp.performDateTime))
        .toList();

    state = newState;
  }

  /// Обновление выполнения привычки: удаление привычек в пределах минуты +
  /// вставка выполнения привычки
  Future<void> update(HabitPerforming hp) async {
    await deleteForDateTime(hp.performDateTime);
    await insert(hp);
  }



}
