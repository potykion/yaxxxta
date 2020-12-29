import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/core/utils/dt.dart';
import 'package:yaxxxta/habit/domain/db.dart';
import 'package:yaxxxta/habit/domain/models.dart';
import 'package:yaxxxta/habit/infra/db.dart';
import 'package:yaxxxta/habit/ui/core/view_models.dart';
import 'package:yaxxxta/habit/ui/details/view_models.dart';
import 'package:yaxxxta/settings/ui/core/deps.dart';

import 'controllers.dart';

/// Регает hive-box для привычек
Provider<Box<Map>> _habitBoxProvider = Provider((_) => Hive.box<Map>("habits"));

/// Регает hive-box для выполнений привычек
Provider<Box<Map>> _habitPerformingBoxProvider =
    Provider((_) => Hive.box<Map>("habit_performings"));

/// Регает репо привычек
Provider<BaseHabitRepo> habitRepoProvider = Provider(
  (ref) => HabitRepo(ref.watch(_habitBoxProvider)),
);

/// Регает репо выполнений привычек
Provider<BaseHabitPerformingRepo> habitPerformingRepoProvider = Provider(
  (ref) => HabitPerformingRepo(ref.watch(_habitPerformingBoxProvider)),
);

var loadingState = StateProvider((_) => true);

var habitsProvider =
    StateProvider((ref) => ref.watch(habitRepoProvider).list());

var todayHabitPerformingsProvider = StateProvider((ref) => <HabitPerforming>[]);

var dateHabitPerfomingsProvider = StateProvider((ref) => <HabitPerforming>[]);

var habitPerformingController = Provider((ref) => HabitPerformingController(
      habitPerformingRepo: ref.watch(habitPerformingRepoProvider),
      dateHabitPerformingsState: ref.watch(dateHabitPerfomingsProvider),
      todayHabitPerformingsState: ref.watch(todayHabitPerformingsProvider),
      settings: ref.watch(settingsProvider).state,
      loadingState: ref.watch(loadingState),
    ));

////////////////////////////////////////////////////////////////////////////////
// HABIT LIST PAGE
////////////////////////////////////////////////////////////////////////////////

var selectedDateProvider = StateProvider((ref) => DateTime.now().date());

Provider<List<ProgressHabitVM>> listHabitVMs = Provider((ref) {
  var selectedDate = ref.watch(selectedDateProvider).state;
  var habitPerformings =
      ref.watch(habitPerformingController).getDateState(selectedDate).state;
  var groupedHabitPerformings =
      groupBy(habitPerformings, (HabitPerforming hp) => hp.habitId);
  var habits = ref.watch(habitsProvider).state;
  var settings = ref.watch(settingsProvider).state;
  return habits
      .map((h) => ProgressHabitVM.build(h, groupedHabitPerformings[h.id] ?? []))
      .where((h) => settings.showCompleted || !h.isComplete)
      .toList();
});

////////////////////////////////////////////////////////////////////////////////
// HABIT DETAILS PAGE
////////////////////////////////////////////////////////////////////////////////

StateProvider<int> selectedHabitId = StateProvider((ref) => null);

var selectedHabit = Provider(
  (ref) => ref
      .watch(habitsProvider)
      .state
      .where((h) => h.id == ref.watch(selectedHabitId).state)
      .first,
);

var selectedHabitPerformings = Provider(
  (ref) => ref
      .watch(todayHabitPerformingsProvider)
      .state
      .where((hp) => hp.habitId == ref.watch(selectedHabitId).state),
);

var detailsHabitVM = Provider(
  (ref) => HabitDetailsPageVM(
    habit: ref.watch(selectedHabit),
    habitPerformings: ref.watch(todayHabitPerformingsProvider).state,
  ),
);
