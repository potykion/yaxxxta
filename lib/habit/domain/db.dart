import 'models.dart';

/// Репо для работы с привычками
abstract class BaseHabitRepo {
  /// Вставляет привычку в бд, возвращая айди
  Future<int> insert(Habit habit);

  /// Выводит список привычек
  List<Habit> list();

  /// Получает привычку по айди
  Habit get(int id);

  /// Обновляет привычку в бд
  Future<void> update(Habit habit);
}
