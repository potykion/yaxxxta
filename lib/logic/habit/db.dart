import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/core/db.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/user/controllers.dart';

import 'models.dart';

/// Репо для работы с привычками
abstract class HabitRepo {
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
abstract class HabitPerformingRepo {
  /// Вставляет выполнение привычки в бд, возвращая айди
  Future<String> insert(HabitPerforming performing);

  /// Выводит список выполнений в промежутке
  Future<List<HabitPerforming>> list(DateTime from, DateTime to);

  /// Выводит список выполнений для привычки
  Future<List<HabitPerforming>> listByHabit(String habitId);

  /// Удаляет выполнения привычки в промежутке
  Future<void> delete(String habitId, DateTime from, DateTime to);

  /// Чекает есть ли выполнения привычки в промежутке
  Future<bool> checkHabitPerformingExistInDateRange(
    String habitId,
    DateTime from,
    DateTime to,
  );
}

/// Фаерстор репо для привычек
class FirebaseHabitRepo extends FirebaseRepo<Habit> implements HabitRepo {
  /// Фаерстор репо для привычек
  FirebaseHabitRepo(CollectionReference collectionReference)
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
class FirebaseHabitPerformingRepo extends FirebaseRepo<HabitPerforming>
    implements HabitPerformingRepo {
  /// Фаер-стор репо для выполнений привычек
  FirebaseHabitPerformingRepo(CollectionReference collectionReference)
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

  Future<List<HabitPerforming>> listByHabits(List<String> habitIds) async =>
      (await listDocsByIds(habitIds, idField: "habitId"))
          .map(entityFromFirebase)
          .toList();

  @override
  Future<void> delete(String habitId, DateTime from, DateTime to) async {
    var batch = FirebaseFirestore.instance.batch();

    var performingsToDelete = (await collectionReference
            .where(
              "performDateTime",
              isGreaterThanOrEqualTo: from,
              isLessThanOrEqualTo: to,
            )
            .where("habitId", isEqualTo: habitId)
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

/// Хайв репо привычек
class HiveHabitRepo extends HiveRepo<Habit> implements HabitRepo {
  /// Хайв репо привычек
  HiveHabitRepo(Box<Map> box) : super(box);

  @override
  Map<String, dynamic> entityToHive(Habit entity) => entity.toJson();

  @override
  Future<Habit> get(String id) async => entityFromHive(id, box.get(id)!);

  @override
  Future<List<Habit>> listByIds(List<String> habitIds) async =>
      habitIds.map((id) => entityFromHive(id, box.get(id)!)).toList();

  @override
  Habit entityFromHive(String id, Map hiveData) {
    return Habit.fromJson(hiveData..["id"] = id);
  }
}

/// Хайв репо выполнений привычек
class HiveHabitPerformingRepo extends HiveRepo<HabitPerforming>
    implements HabitPerformingRepo {
  /// Хайв репо выполнений привычек
  HiveHabitPerformingRepo(Box<Map> box) : super(box);

  @override
  Future<bool> checkHabitPerformingExistInDateRange(
          String habitId, DateTime from, DateTime to) async =>
      (await list(from, to)).any((hp) => hp.habitId == habitId);

  @override
  Future<void> delete(String habitId, DateTime from, DateTime to) async {
    await box.deleteAll((await list(from, to))
        .where((hp) => hp.habitId == habitId)
        .map<String>((hp) => hp.id!));
  }

  @override
  Map<String, dynamic> entityToHive(HabitPerforming entity) => entity.toJson();

  @override
  Future<List<HabitPerforming>> list(DateTime from, DateTime to) async =>
      _getAll().where((hp) => hp.performDateTime.isBetween(from, to)).toList();

  @override
  Future<List<HabitPerforming>> listByHabit(String habitId) async =>
      _getAll().where((hp) => hp.habitId == habitId).toList();

  Iterable<HabitPerforming> _getAll() =>
      box.keys.map((dynamic id) => entityFromHive(id as String, box.get(id)!));

  @override
  HabitPerforming entityFromHive(String id, Map hiveData) =>
      HabitPerforming.fromJson(hiveData..["id"] = id);
}

/// Провайдер HiveHabitRepo
Provider<HiveHabitRepo> hiveHabitRepoProvider =
    Provider((ref) => HiveHabitRepo(Hive.box<Map>("habits")));

/// Провайдер FirebaseHabitRepo
Provider<FirebaseHabitRepo> fbHabitRepoProvider = Provider((ref) =>
    FirebaseHabitRepo(FirebaseFirestore.instance.collection("habits")));

/// Провайдер репо привычек
Provider<HabitRepo> habitRepoProvider = Provider(
  (ref) => ref.watch(isFreeProvider)
      ? ref.watch(hiveHabitRepoProvider)
      : ref.watch(fbHabitRepoProvider),
);

Provider<HiveHabitPerformingRepo> hiveHabitPerformingRepoProvider = Provider(
    (ref) => HiveHabitPerformingRepo(Hive.box<Map>("habit_performings")));
Provider<FirebaseHabitPerformingRepo> fbHabitPerformingRepoProvider = Provider(
    (ref) => FirebaseHabitPerformingRepo(
        FirebaseFirestore.instance.collection("habit_performings")));

/// Провайдер репо выполнений привычек
Provider<HabitPerformingRepo> habitPerformingRepoProvider = Provider(
  (ref) => ref.watch(isFreeProvider)
      ? ref.watch(hiveHabitPerformingRepoProvider)
      : ref.watch(fbHabitPerformingRepoProvider),
);
