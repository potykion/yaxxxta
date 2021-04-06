import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

import 'package:yaxxxta/logic/core/db.dart';
import 'package:yaxxxta/logic/user/controllers.dart';

import 'models.dart';

/// Репо для работы с наградами
abstract class RewardRepo {
  /// Вставляет в бд
  Future<String> insert(Reward entity);

  /// Обновляет в бд
  Future<void> update(Reward entity);

  /// Удаляет по айди
  Future<void> deleteById(String rewardId);

  /// Получает по айди
  Future<List<Reward>> listByIds(List<String> ids);
}

/// Репо для работы с наградами на фаербейз
class FirebaseRewardRepo extends FirebaseRepo<Reward> implements RewardRepo {
  /// Репо для работы с наградами
  FirebaseRewardRepo(
    CollectionReference collectionReference,
    CreateBatch createBatch,
  ) : super(
          collectionReference: collectionReference,
          createBatch: createBatch,
        );

  @override
  Reward entityFromFirebase(DocumentSnapshot doc) =>
      Reward.fromJson(doc.data()!..["id"] = doc.id);

  @override
  Map<String, dynamic> entityToFirebase(Reward entity) => entity.toJson();
}

/// Провайдер FirebaseRewardRepo
Provider<FirebaseRewardRepo> fbRewardRepoProvider = Provider(
  (ref) => FirebaseRewardRepo(
    FirebaseFirestore.instance.collection("rewards"),
    FirebaseFirestore.instance.batch,
  ),
);

/// Провайдер RewardRepo
Provider<RewardRepo> rewardRepoProvider =
    Provider<RewardRepo>((ref) => ref.watch(fbRewardRepoProvider));
