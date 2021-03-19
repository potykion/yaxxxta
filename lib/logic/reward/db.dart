import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaxxxta/logic/core/infra/firebase.dart';

import 'models.dart';

/// Репо для работы с наградами
abstract class RewardRepo {
  /// Вставляет в бд
  Future<String> insert(Reward entity);

  /// Обновляет в бд
  Future<void> update(Reward entity);

  /// Получает по айди
  Future<List<Reward>> listByIds(List<String> ids);
}

/// Репо для работы с наградами на фаербейз
class FirebaseRewardRepo extends FirebaseRepo<Reward> implements RewardRepo {
  /// Репо для работы с наградами
  FirebaseRewardRepo(CollectionReference collectionReference)
      : super(collectionReference);

  @override
  Reward entityFromFirebase(DocumentSnapshot doc) =>
      Reward.fromJson(doc.data()!..["id"] = doc.id);

  @override
  Map<String, dynamic> entityToFirebase(Reward entity) => entity.toJson();
}
