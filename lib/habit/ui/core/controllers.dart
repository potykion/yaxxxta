import 'package:device_info/device_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/dt.dart';
import '../../../core/utils/list.dart';
import '../../../settings/domain/models.dart';
import '../../domain/db.dart';
import '../../domain/models.dart';
import '../../domain/services.dart';

/// Контроллер привычек
class HabitController extends StateNotifier<AsyncValue<List<Habit>>> {
  /// Репо привычек
  final BaseHabitRepo habitRepo;

  /// Инфа о ведре
  final AndroidDeviceInfo deviceInfo;

  final SchedulePerformHabitNotifications schedulePerformHabitNotifications;

  /// Контроллер привычек
  HabitController({
    @required this.habitRepo,
    @required this.deviceInfo,
    @required this.schedulePerformHabitNotifications,
    List<Habit> state = const [],
  }) : super(AsyncValue.data(state));

  /// Грузит список привычек и сеттит в стейт
  Future<void> list() async {
    state = AsyncValue.loading();
    state = AsyncValue.data(await habitRepo.list());
  }

  /// Удаляет привычку
  Future<void> delete(String habitId) async {
    await habitRepo.delete(habitId);
    state = AsyncValue.data([
      ...state.data.value.where((h) => h.id != habitId),
    ]);
  }

  /// Создает или обновляет привычку в зависимости от наличия айди
  Future<Habit> createOrUpdateHabit(Habit habit) async {
    if (habit.deviceId == null) {
      habit = habit.copyWith(deviceId: deviceInfo.id);
    }

    if (habit.isUpdate) {
      await habitRepo.update(habit);
      state = AsyncValue.data([
        for (var h in state.data.value)
          if (h.id == habit.id) habit else h
      ]);
    } else {
      habit = habit.copyWith(id: await habitRepo.insert(habit));
      state = AsyncValue.data([...state.data.value, habit]);
    }

    if (habit.isNotificationsEnabled) {
      await schedulePerformHabitNotifications(habit: habit, resetPending: habit.isUpdate);
    }

    return habit;
  }
}

/// Контроллер выполнений привычек
class HabitPerformingController
    extends StateNotifier<AsyncValue<Map<DateTime, List<HabitPerforming>>>> {
  /// Настроечки
  final Settings settings;

  /// Репо выполнений привычек
  final BaseHabitPerformingRepo repo;

  /// Контроллер выполнений привычек
  HabitPerformingController({
    this.repo,
    this.settings,
    Map<DateTime, List<HabitPerforming>> state = const {},
  }) : super(AsyncValue.data(state));

  /// Грузит выполнения за дату
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

  /// Грузит выполнения для определенной привычки
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

  /// Вставка выполнения
  Future<void> insert(HabitPerforming hp) async {
    var newState = _createNewState();

    hp = hp.copyWith(id: await repo.insert(hp));
    var date = _dateFromDateTime(hp.performDateTime);
    newState[date] = [...(newState[date] ?? []), hp];

    state = AsyncValue.data(newState);
  }

  /// Удаляет выполнения за дату и время в пределах минуты
  /// Напр. для 2020-01-01 10:00 удаляет привычки в промежутке:
  /// 2020-01-01 10:00:00, 2020-01-01 10:59
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
