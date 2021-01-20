import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../domain/db.dart';

import '../domain/models.dart';

/// Репо для работы с привычками
class HiveHabitRepo implements BaseHabitRepo {
  final Box<Map> _habitBox;
  final Uuid _uuid = Uuid();

  /// Создает репо
  HiveHabitRepo(this._habitBox);

  @override
  Future<String> insert(Habit habit) async {
    var id = _uuid.v1();
    var habitWithId = habit.copyWith(id: id);
    await _habitBox.put(id, habitWithId.toJson());
    return id;
  }

  @override
  Future<List<Habit>> list() async =>
      _habitBox.values.map((e) => Habit.fromJson(e)).toList();

  @override
  Future<Habit> get(String id) async => Habit.fromJson(_habitBox.get(id));

  @override
  Future<void> update(Habit habit) => _habitBox.put(habit.id, habit.toJson());

  @override
  Future<void> delete(String id) => _habitBox.delete(id);
}

/// Репо выполнений привычек
class HiveHabitPerformingRepo implements BaseHabitPerformingRepo {
  final Box<Map> _habitPerformingBox;

  /// @nodoc
  HiveHabitPerformingRepo(this._habitPerformingBox);

  @override
  Future<void> insert(HabitPerforming performing) async {
    await _habitPerformingBox.add(performing.toJson());
  }

  @override
  Future<List<HabitPerforming>> list(DateTime from, DateTime to) async =>
      _habitPerformingBox.values
          .map((e) => HabitPerforming.fromJson(e))
          .where(
            (p) =>
                p.performDateTime.isAfter(from) &&
                p.performDateTime.isBefore(to),
          )
          .toList();

  @override
  Future<List<HabitPerforming>> listByHabit(String habitId) async =>
      _habitPerformingBox.values
          .map((e) => HabitPerforming.fromJson(e))
          .where((hp) => hp.habitId == habitId)
          .toList();
}

/// Фаерстор репо для привычек
class FirestoreHabitRepo implements BaseHabitRepo {
  final CollectionReference _collectionReference;

  /// Фаерстор репо для привычек
  FirestoreHabitRepo(this._collectionReference);

  @override
  Future<void> delete(String id) => _collectionReference.doc(id).delete();

  @override
  Future<Habit> get(String id) async =>
      Habit.fromJson((await _collectionReference.doc(id).get()).data())
          .copyWith(id: id);

  @override
  Future<String> insert(Habit habit) async =>
      (await _collectionReference.add(habit.toJson())).id;

  @override
  Future<List<Habit>> list() async => (await _collectionReference.get())
      .docs
      .map((d) => Habit.fromJson(d.data()))
      .toList();

  @override
  Future<void> update(Habit habit) =>
      _collectionReference.doc(habit.id).update(habit.toJson());
}
