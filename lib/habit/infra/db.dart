import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../domain/db.dart';

import '../domain/models.dart';

/// Репо для работы с привычками
class HabitRepo implements BaseHabitRepo {
  final Box<Map> _habitBox;
  final Uuid _uuid = Uuid();

  /// Создает репо
  HabitRepo(this._habitBox);

  @override
  Future<String> insert(Habit habit) async {
    var id = _uuid.v1();
    var habitWithId = habit.copyWith(id: id);
    await _habitBox.put(id, habitWithId.toJson());
    return id;
  }

  @override
  List<Habit> list() => _habitBox.values.map((e) => Habit.fromJson(e)).toList();

  @override
  Habit get(String id) => Habit.fromJson(_habitBox.get(id));

  @override
  Future<void> update(Habit habit) => _habitBox.put(habit.id, habit.toJson());

  @override
  Future<void> delete(String id) => _habitBox.delete(id);
}

/// Репо выполнений привычек
class HabitPerformingRepo implements BaseHabitPerformingRepo {
  final Box<Map> _habitPerformingBox;

  /// @nodoc
  HabitPerformingRepo(this._habitPerformingBox);

  @override
  Future<void> insert(HabitPerforming performing) async {
    await _habitPerformingBox.add(performing.toJson());
  }

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
  List<HabitPerforming> listByHabit(String habitId) =>
      _habitPerformingBox.values
          .map((e) => HabitPerforming.fromJson(e))
          .where((hp) => hp.habitId == habitId)
          .toList();
}
