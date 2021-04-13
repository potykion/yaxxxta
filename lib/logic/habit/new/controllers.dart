import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/db.dart';

import '../models.dart';

class NewHabitPerformingController
    extends StateNotifier<AsyncValue<List<HabitPerforming>>> {
  final HabitPerformingRepo repo;
  final Map<String, List<HabitPerforming>> _cache = {};

  NewHabitPerformingController({
    required this.repo,
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
}

StateNotifierProvider<NewHabitPerformingController,
        AsyncValue<List<HabitPerforming>>>
    newHabitPerformingControllerProvider = StateNotifierProvider<
        NewHabitPerformingController, AsyncValue<List<HabitPerforming>>>(
  (ref) => NewHabitPerformingController(
    repo: ref.watch(habitPerformingRepoProvider),
  ),
);
