import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/habit/ui/core/view_models.dart';

import '../../../deps.dart';
import 'controllers.dart';

/// Регает контроллер, загружая привычки
StateNotifierProvider<HabitListController> habitListControllerProvider =
    StateNotifierProvider(
  (ref) {
    var controller = HabitListController(
      habitRepo: ref.watch(habitRepoProvider),
      habitPerformingRepo: ref.watch(habitPerformingRepoProvider),
      settings: ref.watch(settingsProvider).state,
      createPerforming: ref.watch(createPerforming)
    );
    controller.loadHabits();
    return controller;
  },
);

/// Провайдер привычек, которые отображаются в списке
Provider<List<HabitListPageVM>> habitsToShowProvider = Provider((ref) {
  var settings = ref.watch(settingsProvider).state;

  return ref
      .watch(habitListControllerProvider.state)
      .where((h) => settings.showCompleted || !h.isComplete)
      .toList();
});


/// Вью-моделька привычки
ScopedProvider<HabitListPageVM> habitVMProvider = ScopedProvider<HabitListPageVM>(null);

/// Индекс повтора привычки в течение дня
ScopedProvider<int> repeatIndexProvider = ScopedProvider<int>(null);


