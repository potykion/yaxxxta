import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/core/utils/dt.dart';
import 'package:yaxxxta/deps.dart';
import 'package:yaxxxta/habit/domain/models.dart';
import 'package:yaxxxta/habit/ui/core/view_models.dart';
import 'package:yaxxxta/habit/ui/details/view_models.dart';

var habitsProvider =
    StateProvider((ref) => ref.watch(habitRepoProvider).list());

var dateHabitPerformingsProvider =
    StateProvider<List<HabitPerforming>>((ref) => []);

var todayHabitPerformingsProvider = StateProvider((ref) {
  var settings = ref.watch(settingsProvider).state;

  var date = DateTime.now();
  var dateStart = buildDateTime(date, settings.dayStartTime);
  var dateEnd = buildDateTime(date, settings.dayEndTime);

  return ref.watch(habitPerformingRepoProvider).list(dateStart, dateEnd);
});

////////////////////////////////////////////////////////////////////////////////
// HABIT LIST PAGE
////////////////////////////////////////////////////////////////////////////////

var selectedDate = StateProvider((ref) => DateTime.now().date());

Provider<List<HabitPerforming>> selectedDateHabitPerformings = Provider(
  (ref) => ref.watch(selectedDate) == DateTime.now().date()
      ? ref.watch(todayHabitPerformingsProvider).state
      : ref.watch(dateHabitPerformingsProvider).state,
);

Provider<List<HabitListPageVM>> listHabitVMs = Provider((ref) {
  var habitPerformings = ref.watch(selectedDateHabitPerformings);
  var groupedHabitPerformings =
      groupBy(habitPerformings, (HabitPerforming hp) => hp.habitId);
  var habits = ref.watch(habitsProvider).state;
  return habits
      .map((h) => HabitListPageVM.build(h, groupedHabitPerformings[h.id] ?? []))
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
      habitPerformings: ref.watch(selectedDateHabitPerformings)),
);
