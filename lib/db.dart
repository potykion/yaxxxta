import 'package:hive/hive.dart';

import 'models.dart';

/// Репо для работы с привычками
class HabitRepo {
  final Box<Map> _hiveBox;

  /// Создает репо
  HabitRepo(this._hiveBox);

  /// Вставляет привычку в бд, возвращая айди
  Future<int> insert(Habit habit) => _hiveBox.add(habit.toJson());

  /// Выводит список привычек
  List<Habit> list() => _hiveBox.values.map((h) => Habit.fromJson(h)).toList();

  /// Получает привычку по айди
  Habit get(int id) => Habit.fromJson(_hiveBox.getAt(id))..id = id;

  /// Обновляет привычку в бд
  Future<void> update(Habit habit) => _hiveBox.putAt(habit.id, habit.toJson());
}
