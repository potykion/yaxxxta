import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/db.dart';

import '../models.dart';

class NewHabitPerformingController
    extends StateNotifier<AsyncValue<List<HabitPerforming>>> {
  final HabitPerformingRepo repo;

  NewHabitPerformingController({
    required this.repo,
  }) : super(AsyncValue.data([]));

  Future<void> load(String habitId) async {
    state = AsyncValue.loading();
    state = AsyncValue.data(await repo.listByHabit(habitId));
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


