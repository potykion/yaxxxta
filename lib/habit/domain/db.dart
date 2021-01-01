import 'models.dart';

/// Репо для работы с привычками
abstract class BaseHabitRepo {
  /// Вставляет привычку в бд, возвращая айди
  Future<String> insert(Habit habit);

  /// Выводит список привычек
  List<Habit> list();

  /// Получает привычку по айди
  Habit get(String id);

  /// Обновляет привычку в бд
  Future<void> update(Habit habit);

  Future<void> delete(String id);
}

/// Репо для работы с выполнениями привычек
abstract class BaseHabitPerformingRepo {
  /// Вставляет выполнение привычки в бд, возвращая айди
  Future<void> insert(HabitPerforming performing);

  /// Выводит список выполнений в промежутке
  List<HabitPerforming> list(DateTime from, DateTime to);

  /// Выводит список выполнений для привычки
  List<HabitPerforming> listByHabit(String habitId);
}
