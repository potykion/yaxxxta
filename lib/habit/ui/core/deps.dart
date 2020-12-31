import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/all.dart';

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
  (ref) => HabitRepo(ref.watch(_habitBoxProvider)),
);

/// Регает репо выполнений привычек
Provider<BaseHabitPerformingRepo> habitPerformingRepoProvider = Provider(
  (ref) => HabitPerformingRepo(ref.watch(_habitPerformingBoxProvider)),
);

/// Провайдер состояния загрузи чего-либо
StateProvider<bool> loadingState = StateProvider((_) => true);

/// Провайдер привычек
StateProvider<List<Habit>> habitsProvider =
    StateProvider((ref) => ref.watch(habitRepoProvider).list());

/// Провайдер выполнений привычек за сегодня
StateProvider<List<HabitPerforming>> todayHabitPerformingsProvider =
    StateProvider((ref) => <HabitPerforming>[]);

/// Провайдер выполнений привычек за дату
StateProvider<List<HabitPerforming>> dateHabitPerfomingsProvider =
    StateProvider((ref) => <HabitPerforming>[]);

/// Провайдер контроллера выполнений привычек
Provider<HabitPerformingController> habitPerformingController =
    Provider((ref) => HabitPerformingController(
          habitPerformingRepo: ref.watch(habitPerformingRepoProvider),
          dateHabitPerformingsState: ref.watch(dateHabitPerfomingsProvider),
          todayHabitPerformingsState: ref.watch(todayHabitPerformingsProvider),
          settings: ref.watch(settingsProvider).state,
          loadingState: ref.watch(loadingState),
        ));

////////////////////////////////////////////////////////////////////////////////
// HABIT LIST PAGE
////////////////////////////////////////////////////////////////////////////////

StateProvider<DateTime> selectedDateProvider =
    StateProvider((ref) => DateTime.now().date());

/// Провайдер ВМок для страницы со списком привычек
Provider<List<ProgressHabitVM>> listHabitVMs = Provider((ref) {
  var selectedDate = ref.watch(selectedDateProvider).state;
  var habitPerformings =
      ref.watch(habitPerformingController).getDateState(selectedDate).state;
  var groupedHabitPerformings =
      groupBy<HabitPerforming, int>(habitPerformings, (hp) => hp.habitId);
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

/// Провайдер выбранной привычки
Provider<Habit> selectedHabitProvider = Provider(
  (ref) => ref
      .watch(habitsProvider)
      .state
      .where((h) => h.id == ref.watch(selectedHabitId).state)
      .first,
);

/// Провадер выполнений выбранной привычки
Provider<Iterable<HabitPerforming>> selectedHabitPerformings = Provider(
  (ref) => ref
      .watch(todayHabitPerformingsProvider)
      .state
      .where((hp) => hp.habitId == ref.watch(selectedHabitId).state),
);

/// Провайдер ВМки для страницы деталей привычки
Provider<HabitDetailsPageVM> habitDetailsVMProvider = Provider(
  (ref) => HabitDetailsPageVM(
    habit: ref.watch(selectedHabitProvider),
    habitPerformings: ref.watch(todayHabitPerformingsProvider).state,
  ),
);
