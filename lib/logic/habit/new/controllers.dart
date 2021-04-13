import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/services/perform.dart';

import '../models.dart';

class NewHabitPerformingController
    extends StateNotifier<AsyncValue<List<HabitPerforming>>> {
  final HabitPerformingRepo repo;
  final PerformHabitNow performHabitNow;
  final Map<String, List<HabitPerforming>> _cache = {};

  NewHabitPerformingController({
    required this.repo,
    required this.performHabitNow,
  }) : super(AsyncValue.data([]));

  Future<void> load(String habitId) async {
    if (_cache.containsKey(habitId)) {
      state = AsyncValue.data(_cache[habitId]!);
    } else {
      state = AsyncValue.loading();
      _cache[habitId] = await repo.listByHabit(habitId);
      state = AsyncValue.data(_cache[habitId]!);
    }
  }

  Future<void> perform(Habit habit, [double performValue = 1]) async {
    var hp = await performHabitNow(
      habit: habit,
      performValue: performValue,
    );
    _cache[habit.id!] = [..._cache[habit.id!]!, hp];
    state = AsyncValue.data(_cache[habit.id!]!);
  }
}

StateNotifierProvider<NewHabitPerformingController,
        AsyncValue<List<HabitPerforming>>>
    newHabitPerformingControllerProvider = StateNotifierProvider<
        NewHabitPerformingController, AsyncValue<List<HabitPerforming>>>(
  (ref) => NewHabitPerformingController(
    repo: ref.watch(habitPerformingRepoProvider),
    performHabitNow: ref.watch(performHabitNowProvider),
  ),
);

var todayHabitPerformingsProvider = Provider(
  (ref) => ref.watch(newHabitPerformingControllerProvider).maybeWhen(
        data: (performings) =>
            performings.where((hp) => hp.performDateTime.isToday()).toList(),
        orElse: () => <HabitPerforming>[],
      ),
);
var todayValueProvider = Provider(
  (ref) {
    var todayHabits = ref.watch(todayHabitPerformingsProvider);
    if (todayHabits.isEmpty) return 0;
    return todayHabits.map((hp) => hp.performValue).reduce((v1, v2) => v1 + v2);
  },
);
