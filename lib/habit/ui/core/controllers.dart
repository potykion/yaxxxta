import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../../core/utils/dt.dart';
import '../../../core/utils/list.dart';
import '../../domain/db.dart';
import '../../domain/models.dart';
import '../../domain/services.dart';

/// Контроллер привычек
class HabitController extends StateNotifier<List<Habit>> {
  /// Грузит привычки юзера
  final LoadUserHabits loadUserHabits;

  /// Удаляет привычку
  final DeleteHabit deleteHabit;

  /// Создает или обновляет привычку
  final CreateOrUpdateHabit createOrUpdateHabit;

  /// Контроллер привычек
  HabitController({
    required this.loadUserHabits,
    required this.deleteHabit,
    required this.createOrUpdateHabit,
    List<Habit> state = const [],
  }) : super(state);

  /// Грузит список привычек и сеттит в стейт
  Future<void> load(List<String> userHabitIds) async {
    state = await loadUserHabits(userHabitIds);
  }

  /// Удаляет привычку
  Future<void> delete(String habitId) async {
    await deleteHabit(habitId);
    state = [...state.where((h) => h.id != habitId)];
  }

  /// Создает или обновляет привычку в зависимости от наличия айди
  Future<Habit> createOrUpdate(Habit habit) async {
    var res = await createOrUpdateHabit(habit);
    habit = res.item1;
    var created = res.item2;

    if (created) {
      state = [...state, habit];
    } else {
      state = [
        for (var h in state)
          if (h.id == habit.id) habit else h
      ];
    }

    return habit;
  }
}

/// Контроллер выполнений привычек
class HabitPerformingController
    extends StateNotifier<AsyncValue<Map<DateTime, List<HabitPerforming>>>> {
  /// Репо выполнений привычек
  final BaseHabitPerformingRepo repo;

  /// Настройки начала и конца дня
  final Tuple2<DateTime, DateTime> settingsDayTimes;

  /// Контроллер выполнений привычек
  HabitPerformingController({
    required this.repo,
    required this.settingsDayTimes,
    Map<DateTime, List<HabitPerforming>> state = const {},
  }) : super(AsyncValue.data(state));

  /// Грузит выполнения за дату
  Future<void> loadDateHabitPerformings(DateTime date) async {
    date = date.date();

    var newState = _createNewState();

    state = AsyncValue.loading();

    var dateRange = DateRange.fromDateAndTimes(
      date,
      settingsDayTimes.item1,
      settingsDayTimes.item2,
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
        settingsDayTimes.item1,
        settingsDayTimes.item2,
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
        settingsDayTimes.item1,
        settingsDayTimes.item2,
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
