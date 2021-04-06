import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:yaxxxta/logic/core/db.dart';

import 'models.dart';

/// Репо для работы с данными о юзере
abstract class UserDataRepo {
  /// Получает первую запись с данными юзера
  Future<UserData?> first();

  /// Получает данные юзера по айди юзера
  Future<UserData?> getByUserId(String userId);

  /// Создает данные юзера
  Future<String> insert(UserData userData);

  /// Обновляет данные юзера
  Future<void> update(UserData userData);
}

/// Фаерстор репо для данных о юзере
class FirebaseUserDataRepo extends FirebaseRepo<UserData>
    implements UserDataRepo {
  /// Фаерстор репо для данных о юзере
  FirebaseUserDataRepo(
    CollectionReference collectionReference,
    CreateBatch createBatch,
  ) : super(
          collectionReference: collectionReference,
          createBatch: createBatch,
        );

  @override
  Future<UserData?> getByUserId(String userId) async {
    try {
      var doc =
          (await collectionReference.where("userId", isEqualTo: userId).get())
              .docs
              .first;

      var userData = entityFromFirebase(doc);

      return userData;
      // ignore: avoid_catching_errors
    } on StateError {
      return null;
    }
  }

  @override
  UserData entityFromFirebase(DocumentSnapshot doc) =>
      UserData.fromJson(doc.data()!..["id"] = doc.id);

  @override
  Map<String, dynamic> entityToFirebase(UserData entity) => entity.toJson();

  @override
  Future<UserData?> first() async =>
      entityFromFirebase((await collectionReference.get()).docs.first);
}

/// Провайдер FirebaseUserDataRepo
Provider<FirebaseUserDataRepo> fbUserDataRepoProvider =
    Provider((ref) => FirebaseUserDataRepo(
          FirebaseFirestore.instance.collection("user_data"),
          FirebaseFirestore.instance.batch,
        ));
