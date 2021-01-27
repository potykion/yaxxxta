import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/db.dart';

import '../domain/models.dart';

/// Фаерстор репо для привычек
class FirestoreHabitRepo implements BaseHabitRepo {
  final CollectionReference _collectionReference;

  /// Фаерстор репо для привычек
  FirestoreHabitRepo(this._collectionReference);

  @override
  Future<void> delete(String id) => _collectionReference.doc(id).delete();

  @override
  Future<Habit> get(String id) async =>
      _habitFromFireStore((await _collectionReference.doc(id).get()));

  @override
  Future<String> insert(Habit habit) async =>
      (await _collectionReference.add(_habitToFireStore(habit))).id;

  @override
  Future<List<Habit>> list() async =>
      (await _collectionReference.get()).docs.map(_habitFromFireStore).toList();

  @override
  Future<void> update(Habit habit) =>
      _collectionReference.doc(habit.id).update(_habitToFireStore(habit));

  Map<String, dynamic> _habitToFireStore(Habit habit) =>
      habit.toJson()..["created"] = Timestamp.fromDate(habit.created);

  Habit _habitFromFireStore(DocumentSnapshot doc) {
    var data = doc.data();
    data["created"] = (data["created"] as Timestamp).toDate().toIso8601String();
    data["id"] = doc.id;
    return Habit.fromJson(data);
  }
}

/// Фаер-стор репо для выполнений привычек
class FireStoreHabitPerformingRepo implements BaseHabitPerformingRepo {
  final CollectionReference _collectionReference;

  /// Фаер-стор репо для выполнений привычек
  FireStoreHabitPerformingRepo(this._collectionReference);

  @override
  Future<void> insert(HabitPerforming performing) =>
      _collectionReference.add(_toFireBase(performing));

  @override
  Future<List<HabitPerforming>> list(DateTime from, DateTime to) async =>
      (await _collectionReference
              .where(
                "performDateTime",
                isGreaterThanOrEqualTo: from,
                isLessThanOrEqualTo: to,
              )
              .get())
          .docs
          .map((d) => _fromFireBase(d.data()))
          .toList();

  @override
  Future<List<HabitPerforming>> listByHabit(String habitId) async =>
      (await _collectionReference
              .where(
                "habitId",
                isEqualTo: habitId,
              )
              .get())
          .docs
          .map((d) => _fromFireBase(d.data()))
          .toList();

  Map<String, dynamic> _toFireBase(HabitPerforming performing) =>
      performing.toJson()
        ..["performDateTime"] = Timestamp.fromDate(performing.performDateTime);

  HabitPerforming _fromFireBase(Map doc) => HabitPerforming.fromJson(doc
    ..["performDateTime"] =
        (doc["performDateTime"] as Timestamp).toDate().toIso8601String());
}
