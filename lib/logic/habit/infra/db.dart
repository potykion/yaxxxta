import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaxxxta/logic/core/db.dart';
import '../domain/db.dart';
import '../domain/models.dart';

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
}
