import 'package:hive/hive.dart';

import 'models.dart';

class HabitRepo {
  final Box hiveBox;

  HabitRepo(this.hiveBox);

  Future<int> insert(Habit habit) => hiveBox.add(habit.toJson());

  List<Habit> list() => hiveBox.values.map((h) => Habit.fromJson(h)).toList();

  Habit get(int id) => Habit.fromJson(hiveBox.getAt(id))..id = id;

  Future<void> update(Habit habit) => hiveBox.putAt(habit.id, habit.toJson());
}
