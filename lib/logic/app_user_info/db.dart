import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaxxxta/logic/core/db.dart';

import 'models.dart';

/// Фаерстор репо данных о юзере
class FirebaseAppUserInfoRepo extends FirebaseRepo<AppUserInfo> {
  /// Фаерстор репо данных о юзере
  FirebaseAppUserInfoRepo(
    CollectionReference collectionReference,
  ) : super(collectionReference: collectionReference);

  @override
  AppUserInfo entityFromFirebase(DocumentSnapshot doc) {
    var data = doc.data()!;
    data["id"] = doc.id;
    return AppUserInfo.fromJson(data);
  }

  @override
  Map<String, dynamic> entityToFirebase(AppUserInfo entity) {
    return entity.toJson();
  }
}
