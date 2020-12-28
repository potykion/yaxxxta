import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/core/utils/dt.dart';
import 'package:yaxxxta/deps.dart';
import 'package:yaxxxta/habit/domain/models.dart';
import 'package:yaxxxta/habit/ui/core/view_models.dart';
import 'package:yaxxxta/habit/ui/details/view_models.dart';

var habitsProvider =
    StateProvider((ref) => ref.watch(habitRepoProvider).list());

var todayHabitPerformingsProvider = StateProvider((ref) =>
    ref.watch(loadDateHabitPerformingsProvider)(DateTime.now().date()));

var dateHabitPerfomingsProvider = StateProvider((ref) => <HabitPerforming>[]);

////////////////////////////////////////////////////////////////////////////////
// HABIT LIST PAGE
////////////////////////////////////////////////////////////////////////////////

var selectedDateProvider = StateProvider((ref) => DateTime.now().date());

var selectedDateHabitPerformings = Provider((ref) {
  var selectedDate = ref.watch(selectedDateProvider).state;
  return selectedDate == DateTime.now().date()
      ? ref.watch(todayHabitPerformingsProvider).state
      : ref.watch(dateHabitPerfomingsProvider).state;
});


Provider<List<ProgressHabitVM>> listHabitVMs = Provider((ref) {
  var habitPerformings = ref.watch(selectedDateHabitPerformings);
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
