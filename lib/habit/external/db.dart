import 'package:hive/hive.dart';
import 'package:yaxxxta/habit/domain/db.dart';

import '../domain/models.dart';

/// Репо для работы с привычками
class HabitRepo implements BaseHabitRepo {
  final Box<Map> _hiveBox;

  /// Создает репо
  HabitRepo(this._hiveBox);

  /// Вставляет привычку в бд, возвращая айди
  Future<int> insert(Habit habit) => _hiveBox.add(habit.toJson());

  /// Выводит список привычек
  List<Habit> list() => _hiveBox.values
      .toList()
      .asMap()
      .entries
      .map((e) => Habit.fromJson(e.value).copyWith(id: e.key))
      .toList();

  /// Получает привычку по айди
  Habit get(int id) => Habit.fromJson(_hiveBox.getAt(id)).copyWith(id: id);

  /// Обновляет привычку в бд
  Future<void> update(Habit habit) => _hiveBox.putAt(habit.id, habit.toJson());
}
