import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaxxxta/logic/core/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';

class FirebaseHabitRepo extends FirebaseRepo<Habit> {
  /// Фаерстор репо для привычек
  FirebaseHabitRepo(
    CollectionReference collectionReference,
  ) : super(
          collectionReference: collectionReference,
        );

  @override
  Habit entityFromFirebase(DocumentSnapshot doc) {
    var data = doc.data()!;
    data["id"] = doc.id;
    return Habit.fromJson(data);
  }

  @override
  Map<String, dynamic> entityToFirebase(Habit entity) {
    return entity.toJson();
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
}
