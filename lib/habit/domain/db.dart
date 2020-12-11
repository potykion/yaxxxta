import 'models.dart';

abstract class BaseHabitRepo {
  Future<int> insert(Habit habit);
  List<Habit> list();
  Habit get(int id);
  Future<void> update(Habit habit);
}