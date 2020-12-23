import 'package:hive/hive.dart';
import '../domain/db.dart';

import '../domain/models.dart';

/// Репо для работы с привычками
class HabitRepo implements BaseHabitRepo {
  final Box<Map> _habitBox;

  /// Создает репо
  HabitRepo(this._habitBox);

  @override
  Future<int> insert(Habit habit) => _habitBox.add(habit.toJson());

  @override
  List<Habit> list() => _habitBox.values
      .toList()
      .asMap()
      .entries
      .map((e) => Habit.fromJson(e.value).copyWith(id: e.key))
      .toList();

  @override
  Habit get(int id) => Habit.fromJson(_habitBox.getAt(id)).copyWith(id: id);

  @override
  Future<void> update(Habit habit) => _habitBox.putAt(habit.id, habit.toJson());
}

/// Репо выполнений привычек
class HabitPerformingRepo implements BaseHabitPerformingRepo {
  final Box<Map> _habitPerformingBox;

  /// @nodoc
  HabitPerformingRepo(this._habitPerformingBox);

  @override
  Future<int> insert(HabitPerforming performing) =>
      _habitPerformingBox.add(performing.toJson());

  @override
  List<HabitPerforming> list(DateTime from, DateTime to) => _habitPerformingBox
      .values
      .map((e) => HabitPerforming.fromJson(e))
      .where(
        (p) =>
            p.performDateTime.isAfter(from) && p.performDateTime.isBefore(to),
      )
      .toList();

  @override
  List<HabitPerforming> listByHabit(int habitId) => _habitPerformingBox.values
      .map((e) => HabitPerforming.fromJson(e))
      .where((hp) => hp.habitId == habitId)
      .toList();
}
