import 'package:hive/hive.dart';

import 'models.dart';

class HabitRepo {
  final Box hiveBox;

  HabitRepo(this.hiveBox);

  Future<int> insert(Habit habit) => hiveBox.add(habit.toJson());
}
