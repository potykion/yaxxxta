import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaxxxta/logic/core/db.dart';

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

  /// Чекает есть ли выполнения привычки в промежутке
  Future<bool> checkHabitPerformingExistInDateRange(
    String habitId,
    DateTime from,
    DateTime to,
  );
}

/// Фаерстор репо для привычек
class FirestoreHabitRepo extends FirebaseRepo<Habit> implements BaseHabitRepo {
  /// Фаерстор репо для привычек
  FirestoreHabitRepo(CollectionReference collectionReference)
      : super(collectionReference);

  @override
  Habit entityFromFirebase(DocumentSnapshot doc) {
    var data = doc.data()!;
    data["created"] = (data["created"] as Timestamp).toDate().toIso8601String();
    data["id"] = doc.id;
    return Habit.fromJson(data);
  }

  @override
  Map<String, dynamic> entityToFirebase(Habit entity) =>
      entity.toJson()..["created"] = Timestamp.fromDate(entity.created);
}

/// Фаер-стор репо для выполнений привычек
class FireStoreHabitPerformingRepo extends FirebaseRepo<HabitPerforming>
    implements BaseHabitPerformingRepo {
  /// Фаер-стор репо для выполнений привычек
  FireStoreHabitPerformingRepo(CollectionReference collectionReference)
      : super(collectionReference);

  @override
  Future<List<HabitPerforming>> list(DateTime from, DateTime to) async =>
      (await collectionReference
              .where(
                "performDateTime",
                isGreaterThanOrEqualTo: from,
                isLessThanOrEqualTo: to,
              )
              .get())
          .docs
          .map(entityFromFirebase)
          .toList();

  @override
  Future<List<HabitPerforming>> listByHabit(String habitId) async =>
      (await collectionReference.where("habitId", isEqualTo: habitId).get())
          .docs
          .map(entityFromFirebase)
          .toList();

  @override
  Future<void> delete(DateTime from, DateTime to) async {
    var batch = FirebaseFirestore.instance.batch();

    var performingsToDelete = (await collectionReference
            .where(
              "performDateTime",
              isGreaterThanOrEqualTo: from,
              isLessThanOrEqualTo: to,
            )
            .get())
        .docs;
    for (var hpDoc in performingsToDelete) {
      batch.delete(hpDoc.reference);
    }

    await batch.commit();
  }

  @override
  HabitPerforming entityFromFirebase(DocumentSnapshot doc) {
    var data = doc.data()!;

    return HabitPerforming.fromJson(
      data
        ..["performDateTime"] =
            (data["performDateTime"] as Timestamp).toDate().toIso8601String()
        ..["id"] = doc.id,
    );
  }

  @override
  Map<String, dynamic> entityToFirebase(HabitPerforming performing) =>
      performing.toJson()
        ..["performDateTime"] = Timestamp.fromDate(performing.performDateTime);

  @override
  Future<bool> checkHabitPerformingExistInDateRange(
    String habitId,
    DateTime from,
    DateTime to,
  ) async =>
      (await collectionReference
              .where(
                "performDateTime",
                isGreaterThanOrEqualTo: from,
                isLessThanOrEqualTo: to,
              )
              .where("habitId", isEqualTo: habitId)
              .get())
          .size >
      0;
}
