import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaxxxta/logic/core/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';

class FirebaseHabitRepo extends FirebaseRepo<Habit> {
  final WriteBatch Function() getWriteBatch;

  /// Фаерстор репо для привычек
  FirebaseHabitRepo(
    CollectionReference collectionReference,
    this.getWriteBatch,
  ) : super(collectionReference: collectionReference);

  @override
  Habit entityFromFirebase(DocumentSnapshot doc) {
    var data = doc.data()!;
    data["id"] = doc.id;
    data["order"] = data["order"] ?? DateTime.now().millisecondsSinceEpoch;
    return Habit.fromJson(data);
  }

  @override
  Map<String, dynamic> entityToFirebase(Habit entity) {
    return entity.toJson();
  }

  Future<void> reorder(Map<String, int> habitNewOrders) async {
    var writeBatch = getWriteBatch();

    for (var habitIdAndOrder in habitNewOrders.entries) {
      writeBatch.update(
        collectionReference.doc(habitIdAndOrder.key),
        <String, int>{"order": habitIdAndOrder.value},
      );
    }
    await writeBatch.commit();
  }
}

class FirebaseHabitPerformingRepo extends FirebaseRepo<HabitPerforming> {
  FirebaseHabitPerformingRepo(
    CollectionReference collectionReference,
  ) : super(
          collectionReference: collectionReference,
        );

  @override
  HabitPerforming entityFromFirebase(DocumentSnapshot doc) {
    var data = doc.data()!;
    data["id"] = doc.id;
    data["created"] = (data["created"] as Timestamp).toDate().toIso8601String();
    return HabitPerforming.fromJson(data);
  }

  @override
  Map<String, dynamic> entityToFirebase(HabitPerforming entity) {
    return entity.toJson()..["created"] = Timestamp.fromDate(entity.created);
  }

  /// Выводит выполнения привычек
  /// отфильтрованные по юзеру и отсортированные по дате
  Future<List<HabitPerforming>> listSortedByCreatedAndFilterByUserId(
    String userId,
  ) async =>
      (await collectionReference
              .where("userId", isEqualTo: userId)
              .orderBy("created", descending: true)
              .get())
          .docs
          .map(entityFromFirebase)
          .toList();
}
