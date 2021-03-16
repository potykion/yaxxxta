import 'models.dart';

/// Репо для работы с привычками
abstract class BaseHabitRepo {
  /// Вставляет привычку в бд, возвращая айди
  Future<String> insert(Habit habit);

  /// Выводит список привычек
  Future<List<Habit>> listByIds(List<String> habitIds);

  /// Получает привычку по айди
  @deprecated
  Future<Habit> get(String id);

  /// Обновляет привычку в бд
  Future<void> update(Habit habit);

  /// Удаляет привычку
  Future<void> deleteById(String id);
}

/// Репо для работы с выполнениями привычек
abstract class BaseHabitPerformingRepo {
  /// Вставляет выполнение привычки в бд, возвращая айди
  Future<String> insert(HabitPerforming performing);

  /// Выводит список выполнений в промежутке
  Future<List<HabitPerforming>> list(DateTime from, DateTime to);

  /// Выводит список выполнений для привычки
  Future<List<HabitPerforming>> listByHabit(String habitId);

  /// Удаляет выполнения привычки в промежутке
  Future<void> delete(DateTime from, DateTime to);
}
