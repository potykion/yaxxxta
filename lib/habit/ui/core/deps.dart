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

/// Провайдер ВМок для страницы со списком привычек
Provider<AsyncValue<List<HabitProgressVM>>> listHabitVMs = Provider((ref) {
  return ref.watch(habitPerformingController.state).whenData(
    (dateHabitPerformings) {
      var selectedDate = ref.watch(selectedDateProvider).state;
      var settings = ref.watch(settingsProvider).state;

      var groupedHabitPerformings = groupBy<HabitPerforming, String>(
          dateHabitPerformings[selectedDate] ?? [], (hp) => hp.habitId);

      return ref
          .watch(habitsProvider)
          .state
          .where((h) => h.matchDate(selectedDate))
          .map((h) =>
              HabitProgressVM.build(h, groupedHabitPerformings[h.id] ?? []))
          .where(
              (h) => settings.showCompleted || !h.isComplete && !h.isExceeded)
          .toList()
            ..sort((h1, h2) => h1.performTime == null
                ? (h2.performTime == null ? 0 : 1)
                : (h2.performTime == null
                    ? -1
                    : h1.performTime.compareTo(h2.performTime)));
    },
  );
});

////////////////////////////////////////////////////////////////////////////////
// HABIT DETAILS PAGE
////////////////////////////////////////////////////////////////////////////////

StateProvider<String> selectedHabitIdProvider = StateProvider((ref) => null);

/// Дейтренж текущего дня
Provider<DateRange> todayDateRange = Provider((ref) {
  var settings = ref.watch(settingsProvider).state;

  return DateRange.fromDateAndTimes(
    DateTime.now(),
    settings.dayStartTime,
    settings.dayEndTime,
  );
});

/// Провайдер ВМ страницы деталей привычки
Provider<AsyncValue<HabitDetailsPageVM>> habitDetailsPageVMProvider = Provider(
  (ref) => ref.watch(habitPerformingController.state).whenData((performings) {
    var selectedHabitId = ref.watch(selectedHabitIdProvider).state;
    var selectedHabit = ref.watch(habitsProvider).state.firstWhere(
          (h) => h.id == selectedHabitId,
          orElse: () => null,
        );
    var selectedHabitPerformings = performings.map(
      (key, value) => MapEntry(
        key,
        value.where((hp) => hp.habitId == selectedHabitId).toList(),
      ),
    );

    var todaySelectedHabitPerformings =
        selectedHabitPerformings[ref.watch(todayDateRange).date];
    var progress = HabitProgressVM.build(
      selectedHabit,
      todaySelectedHabitPerformings,
    );

    var history = HabitHistory.fromMap(selectedHabitPerformings);

    return HabitDetailsPageVM(
      habit: selectedHabit,
      progress: progress,
      history: history,
    );
  }),
);
