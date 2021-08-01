import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/core/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';

/// Фаерстор репо для привычек
class FirebaseHabitRepo extends FirebaseRepo<Habit> {
  /// Фаерстор репо для привычек
  FirebaseHabitRepo(
    CollectionReference collectionReference,
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
}

/// Фаерстор репо для выполнений привычек
class FirebaseHabitPerformingRepo extends FirebaseRepo<HabitPerforming> {
  /// Фаерстор репо для выполнений привычек
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

/// Провайдер репо привычек
Provider<FirebaseHabitRepo> habitRepoProvider = Provider(
  (ref) => FirebaseHabitRepo(
    FirebaseFirestore.instance.collection("FirebaseHabitRepo"),
  ),
);

/// Провайдер репо выполнений привычек
Provider<FirebaseHabitPerformingRepo> habitPerformingRepoProvider = Provider(
  (ref) => FirebaseHabitPerformingRepo(
    FirebaseFirestore.instance.collection("FirebaseHabitPerformingRepo"),
  ),
);
