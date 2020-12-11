import 'package:hive/hive.dart';
import '../domain/db.dart';

import '../domain/models.dart';

/// Репо для работы с привычками
class HabitRepo implements BaseHabitRepo {
  final Box<Map> _hiveBox;

  /// Создает репо
  HabitRepo(this._hiveBox);

  @override
  Future<int> insert(Habit habit) => _hiveBox.add(habit.toJson());

  @override
  List<Habit> list() => _hiveBox.values
      .toList()
      .asMap()
      .entries
      .map((e) => Habit.fromJson(e.value).copyWith(id: e.key))
      .toList();

  @override
  Habit get(int id) => Habit.fromJson(_hiveBox.getAt(id)).copyWith(id: id);

  @override
  Future<void> update(Habit habit) => _hiveBox.putAt(habit.id, habit.toJson());
}
