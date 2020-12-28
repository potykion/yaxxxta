import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/habit/domain/db.dart';
import 'package:yaxxxta/habit/domain/use_cases.dart';

import 'view_models.dart';

class HabitDetailsController extends StateNotifier<HabitDetailsPageVM> {
  final BaseHabitRepo habitRepo;
  final BaseHabitPerformingRepo habitPerformingRepo;
  final CreateHabitPerforming createPerforming;

  HabitDetailsController({
    @required this.habitRepo,
    @required this.habitPerformingRepo,
    @required this.createPerforming,
  }) : super(HabitDetailsPageVM(habit: null, habitPerformings: []));

  void load(int habitId) {
    state = HabitDetailsPageVM(
      habit: habitRepo.get(habitId),
      habitPerformings: habitPerformingRepo.listByHabit(habitId),
    );
  }

  Future<void> createPerformingAndUpdateHistory({
    @required int habitId,
    @required int repeatIndex,
    double performValue,
    DateTime performDateTime,
  }) async {
    var performing = await createPerforming(
        habitId: habitId,
        repeatIndex: repeatIndex,
        performValue: performValue,
        performDateTime: performDateTime,
    );
    state = state.copyWith(
      habitPerformings: [...state.habitPerformings, performing],
    );
  }
}
