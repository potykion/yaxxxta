import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
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

/// Регает hive-box для привычек
Provider<Box<Map>> _habitBoxProvider = Provider((_) => Hive.box<Map>("habits"));

/// Регает hive-box для выполнений привычек
Provider<Box<Map>> _habitPerformingBoxProvider =
    Provider((_) => Hive.box<Map>("habit_performings"));

/// Регает репо привычек
Provider<BaseHabitRepo> habitRepoProvider = Provider(
  (ref) =>
      HiveHabitRepo(ref.watch(_habitBoxProvider)),
      // FirestoreHabitRepo(ref.watch(habitCollectionRefProvider)),
);

/// Регает репо выполнений привычек
Provider<BaseHabitPerformingRepo> habitPerformingRepoProvider = Provider(
  (ref) => HiveHabitPerformingRepo(ref.watch(_habitPerformingBoxProvider)),
);

/// Провайдер состояния загрузи чего-либо
StateProvider<bool> loadingState = StateProvider((_) => true);

/// Провайдер привычек
StateProvider<List<Habit>> habitsProvider = StateProvider((ref) => []);

/// Провайдер выполнений привычек за сегодня
StateProvider<List<HabitPerforming>> todayHabitPerformingsProvider =
    StateProvider((ref) => <HabitPerforming>[]);

/// Провайдер выполнений привычек за дату
StateProvider<List<HabitPerforming>> dateHabitPerformingsProvider =
    StateProvider((ref) => <HabitPerforming>[]);

/// Провайдер контроллера выполнений привычек
Provider<HabitPerformingController> habitPerformingController =
    Provider((ref) => HabitPerformingController(
          habitPerformingRepo: ref.watch(habitPerformingRepoProvider),
          dateHabitPerformingsState: ref.watch(dateHabitPerformingsProvider),
          todayHabitPerformingsState: ref.watch(todayHabitPerformingsProvider),
          settings: ref.watch(settingsProvider).state,
          loadingState: ref.watch(loadingState),
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

/// Провайдер ВМок для страницы со списком привычек
Provider<List<HabitProgressVM>> listHabitVMs = Provider((ref) {
  var selectedDate = ref.watch(selectedDateProvider).state;
  var habitPerformings =
      ref.watch(habitPerformingController).getDateState(selectedDate).state;
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
                : h1.performTime
                    .compareTo(h2.performTime)));
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

/// Провайдер выполнений выбранной привычки за сегодня
Provider<List<HabitPerforming>> todaySelectedHabitPerformingsProvider =
    Provider(
  (ref) => ref
      .watch(todayHabitPerformingsProvider)
      .state
      .where((hp) => hp.habitId == ref.watch(selectedHabitId).state)
      .toList(),
);

/// Провайдер выполнений выбранной привычки за все время, кроме сегодня
StateProvider<List<HabitPerforming>> notTodaySelectedHabitPerformingsProvider =
    StateProvider((ref) => []);

/// Провадер выполнений выбранной привычки
Provider<List<HabitPerforming>> selectedHabitPerformingsProvider = Provider(
  (ref) => [
    ...ref.watch(todaySelectedHabitPerformingsProvider),
    ...ref.watch(notTodaySelectedHabitPerformingsProvider).state
  ],
);

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
  (ref) => HabitHistory.fromPerformings(
    ref.watch(selectedHabitPerformingsProvider),
    ref.watch(settingsProvider).state,
  ),
);
