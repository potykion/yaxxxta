import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/core/db.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/transactions/models.dart';
import 'package:yaxxxta/logic/user/controllers.dart';

abstract class PerformingPointTransactionRepo {
  Future<bool> checkHabitTransactionExistsInDateRange(
    String habitId,
    DateRange todayDateRange,
  );

  Future<String> insert(PerformingPointTransaction trans);
}

class HivePerformingPointTransactionRepo
    extends HiveRepo<PerformingPointTransaction>
    implements PerformingPointTransactionRepo {
  HivePerformingPointTransactionRepo(Box<Map> box) : super(box);

  @override
  PerformingPointTransaction entityFromHive(
      String id, Map<dynamic, dynamic> hiveData) {
    // TODO: implement entityFromHive
    throw UnimplementedError();
  }

  @override
  Map entityToHive(PerformingPointTransaction entity) {
    // TODO: implement entityToHive
    throw UnimplementedError();
  }

  @override
  Future<bool> checkHabitTransactionExistsInDateRange(
      String habitId, DateRange todayDateRange) {
    // TODO: implement checkHabitTransactionExistsInDateRange
    throw UnimplementedError();
  }
}

class FireBasePerformingPointTransactionRepo
    extends FirebaseRepo<PerformingPointTransaction>
    implements PerformingPointTransactionRepo {
  FireBasePerformingPointTransactionRepo(
    CollectionReference collectionReference,
    CreateBatch createBatch,
  ) : super(
          collectionReference: collectionReference,
          createBatch: createBatch,
        );

  @override
  PerformingPointTransaction entityFromFirebase(DocumentSnapshot doc) {
    // TODO: implement entityFromFirebase
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> entityToFirebase(PerformingPointTransaction entity) {
    // TODO: implement entityToFirebase
    throw UnimplementedError();
  }

  @override
  Future<bool> checkHabitTransactionExistsInDateRange(String habitId, DateRange todayDateRange) {
    // TODO: implement checkHabitTransactionExistsInDateRange
    throw UnimplementedError();
  }
}

var hivePerformingPointTransactionRepoProvider = Provider((_) =>
    HivePerformingPointTransactionRepo(
        Hive.box<Map>("HivePerformingPointTransactionRepo")));

var fbPerformingPointTransactionRepoProvider = Provider(
  (_) => FireBasePerformingPointTransactionRepo(
    FirebaseFirestore.instance
        .collection("FireBasePerformingPointTransactionRepo"),
    FirebaseFirestore.instance.batch,
  ),
);

/// Провайдер репо привычек
Provider<PerformingPointTransactionRepo> transactionRepoProvider = Provider(
  (ref) => ref.watch(isFreeProvider)
      ? ref.watch(hivePerformingPointTransactionRepoProvider)
      : ref.watch(fbPerformingPointTransactionRepoProvider),
);
