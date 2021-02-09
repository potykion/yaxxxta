import 'package:device_info/device_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/dt.dart';
import '../../../core/utils/list.dart';
import '../../../settings/domain/models.dart';
import '../../domain/db.dart';
import '../../domain/models.dart';

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
    extends StateNotifier<AsyncValue<Map<DateTime, List<HabitPerforming>>>> {
  final Settings settings;
  final BaseHabitPerformingRepo repo;

  HabitPerformingController({
    this.repo,
    this.settings,
    Map<DateTime, List<HabitPerforming>> state = const {},
  }) : super(AsyncValue.data(state));

  Future<void> loadDateHabitPerformings(DateTime date) async {
    date = date.date();

    var newState = _createNewState();

    state = AsyncValue.loading();

    var dateRange = DateRange.fromDateAndTimes(
      date,
      settings.dayStartTime,
      settings.dayEndTime,
    );

    newState[date] = <HabitPerforming>[
      ...(newState[date] ?? []),
      ...await repo.list(dateRange.from, dateRange.to)
    ].distinctBy((item) => item.id);

    state = AsyncValue.data(newState);
  }

  Future<void> loadSelectedHabitPerformings(String habitId) async {
    var newState = _createNewState();

    state = AsyncValue.loading();

    var performings = await repo.listByHabit(habitId);

    var datePerformings = groupBy<HabitPerforming, DateTime>(
      performings,
      (hp) => DateRange.fromDateTimeAndTimes(
        hp.performDateTime,
        settings.dayStartTime,
        settings.dayEndTime,
      ).date,
    );

    for (var dateAndPerformings in datePerformings.entries) {
      newState[dateAndPerformings.key] = <HabitPerforming>[
        ...(newState[dateAndPerformings.key] ?? []),
        ...dateAndPerformings.value
      ].distinctBy((item) => item.id);
    }

    state = AsyncValue.data(newState);
  }

  Map<DateTime, List<HabitPerforming>> _createNewState() =>
      Map.of(state.data?.value ?? <DateTime, List<HabitPerforming>>{});

  DateTime _dateFromDateTime(DateTime dateTime) =>
      DateRange.fromDateTimeAndTimes(
        dateTime,
        settings.dayStartTime,
        settings.dayEndTime,
      ).date;

  Future<void> insert(HabitPerforming hp) async {
    var newState = _createNewState();

    hp = hp.copyWith(id: await repo.insert(hp));
    var date = _dateFromDateTime(hp.performDateTime);
    newState[date] = [...(newState[date] ?? []), hp];

    state = AsyncValue.data(newState);
  }

  Future<void> deleteForDateTime(DateTime dateTime) async {
    var newState = _createNewState();

    var dateRange = DateRange.withinMinute(dateTime);
    await repo.delete(dateRange.from, dateRange.to);
    var date = _dateFromDateTime(dateTime);

    newState[date] = (newState[date] ?? <HabitPerforming>[])
        .where((hp) => !dateRange.containsDateTime(hp.performDateTime))
        .toList();

    state = AsyncValue.data(newState);
  }

  /// Обновление выполнения привычки: удаление привычек в пределах минуты +
  /// вставка выполнения привычки
  Future<void> update(HabitPerforming hp) async {
    await deleteForDateTime(hp.performDateTime);
    await insert(hp);
  }
}
