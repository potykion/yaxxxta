import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/habit/domain/db.dart';

import 'view_models.dart';

class HabitDetailsController extends StateNotifier<HabitDetailsVM> {
  final BaseHabitRepo habitRepo;
  final BaseHabitPerformingRepo habitPerformingRepo;

  HabitDetailsController({
    @required this.habitRepo,
    @required this.habitPerformingRepo,
  }) : super(HabitDetailsVM(habit: null, habitPerformings: []));

  void load(int habitId) {
    state = HabitDetailsVM(
      habit: habitRepo.get(habitId),
      habitPerformings: habitPerformingRepo.listByHabit(habitId),
    );
  }


}
