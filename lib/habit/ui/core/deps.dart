import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/all.dart';
import '../../../core/ui/deps.dart';

import '../../../core/utils/dt.dart';
import '../../../settings/ui/core/deps.dart';
import '../../domain/db.dart';
import '../../domain/models.dart';
import '../../infra/db.dart';
import '../details/view_models.dart';
import 'controllers.dart';
import 'view_models.dart';

/// Регает репо привычек
Provider<BaseHabitRepo> habitRepoProvider = Provider(
    (ref) => FirestoreHabitRepo(ref.watch(habitCollectionRefProvider)));

/// Регает репо выполнений привычек
Provider<BaseHabitPerformingRepo> habitPerformingRepoProvider = Provider(
  (ref) => FireStoreHabitPerformingRepo(
      ref.watch(habitPerformingCollectionRefProvider)),
);

/// Провайдер состояния загрузи чего-либо
StateProvider<bool> loadingState = StateProvider((_) => false);

/// Провайдер привычек
StateProvider<List<Habit>> habitsProvider = StateProvider((ref) => []);

/// Провайдер контроллера выполнений привычек
StateNotifierProvider<HabitPerformingController> habitPerformingController =
    StateNotifierProvider((ref) => HabitPerformingController(
          repo: ref.watch(habitPerformingRepoProvider),
          settings: ref.watch(settingsProvider).state,
        ));

/// Провайдер контроллера привычек
Provider<HabitController> habitControllerProvider =
    Provider((ref) => HabitController(
          habitRepo: ref.watch(habitRepoProvider),
          habitState: ref.watch(habitsProvider),
          deviceInfo: androidInfo,
        ));

////////////////////////////////////////////////////////////////////////////////
// HABIT LIST PAGE
////////////////////////////////////////////////////////////////////////////////

StateProvider<DateTime> selectedDateProvider =
    StateProvider((ref) => DateTime.now().date());

// List<HabitPerforming> getForDateTime(DateTime dateTime) =>
//     getForDate(_dateFromDateTime(dateTime));
//
// List<HabitPerforming> getForDate(DateTime date) => state[date] ?? [];
//
// Map<DateTime, List<HabitPerforming>> getForHabit(String habitId) =>
//     state.map((key, value) =>
//         MapEntry(key, value.where((hp) => hp.habitId == habitId).toList()));

var selectedDateHabitPerformings = Provider((ref) {
  var selectedDate = ref.watch(selectedDateProvider).state;
  var dateHabitPerformings = ref.watch(habitPerformingController.state);
  return dateHabitPerformings[selectedDate] ?? [];
});

/// Провайдер ВМок для страницы со списком привычек
Provider<List<HabitProgressVM>> listHabitVMs = Provider((ref) {
  var selectedDate = ref.watch(selectedDateProvider).state;
  var habitPerformings = ref.watch(selectedDateHabitPerformings);
  var groupedHabitPerformings =
      groupBy<HabitPerforming, String>(habitPerformings, (hp) => hp.habitId);
  var habits = ref.watch(habitsProvider).state;
  var settings = ref.watch(settingsProvider).state;
  var vms = habits
      .where((h) => h.matchDate(selectedDate))
      .map((h) => HabitProgressVM.build(h, groupedHabitPerformings[h.id] ?? []))
      .where((h) => settings.showCompleted || !h.isComplete && !h.isExceeded)
      .toList()
        ..sort((h1, h2) => h1.performTime == null
            ? (h2.performTime == null ? 0 : 1)
            : (h2.performTime == null
                ? -1
                : h1.performTime.compareTo(h2.performTime)));
  return vms;
});

////////////////////////////////////////////////////////////////////////////////
// HABIT DETAILS PAGE
////////////////////////////////////////////////////////////////////////////////

StateProvider<String> selectedHabitId = StateProvider((ref) => null);

/// Провайдер выбранной привычки
Provider<Habit> selectedHabitProvider = Provider(
  (ref) => ref.watch(habitsProvider).state.firstWhere(
        (h) => h.id == ref.watch(selectedHabitId).state,
        orElse: () => null,
      ),
);

/// Провайдер выполнений выбранной привычки за все время, кроме сегодня
StateProvider<List<HabitPerforming>> notTodaySelectedHabitPerformingsProvider =
    StateProvider((ref) => []);

var selectedHabitPerformingsProvider = Provider((ref) {
  var habitId = ref.watch(selectedHabitId);
  return ref.watch(habitPerformingController.state).map((key, value) =>
      MapEntry(key, value.where((hp) => hp.habitId == habitId).toList()));
});

var todayDateRange = Provider((ref) {
  var settings = ref.watch(settingsProvider).state;

  return DateRange.fromDateAndTimes(
    DateTime.now(),
    settings.dayStartTime,
    settings.dayEndTime,
  );
});

var todaySelectedHabitPerformingsProvider = Provider((ref) => ref
    .watch(selectedHabitPerformingsProvider)[ref.watch(todayDateRange).date]);

/// Повайдер вмки прогресса выбранной привычки
Provider<HabitProgressVM> selectedHabitProgressProvider = Provider(
  (ref) => ref.watch(selectedHabitProvider) != null
      ? HabitProgressVM.build(
          ref.watch(selectedHabitProvider),
          ref.watch(todaySelectedHabitPerformingsProvider),
        )
      : null,
);

/// Провайдер истории выбранной привычки
Provider<HabitHistory> selectedHabitHistoryProvider = Provider(
  (ref) => HabitHistory.fromMap(
    ref.watch(selectedHabitPerformingsProvider),
  ),
);
