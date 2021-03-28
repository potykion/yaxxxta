import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/logic/user/db.dart';
import 'package:yaxxxta/logic/user/models.dart';

void main() {
  group("Тестим FirestoreUserDataRepo", () {
    late FirebaseFirestore instance;
    late FirebaseUserDataRepo repo;

    setUp(() {
      instance = MockFirestoreInstance();
      repo = FirebaseUserDataRepo(instance.collection('user_data'));
    });

    test("FirestoreUserDataRepo.create", () async {
      await repo.insert(UserData.blank());
      var insertedUserData = (await instance.collection("user_data").get())
          .docs
          .map((doc) => UserData.fromJson(doc.data()!))
          .first;

      expect(insertedUserData, UserData.blank());
    });

    test("FirestoreUserDataRepo.getByUserId", () async {
      var initUserData = UserData.blank(userId: "tests");
      var id = await repo.insert(initUserData);

      var userData = await repo.getByUserId("tests");

      expect(userData, initUserData.copyWith(id: id));
    });

    test("FirestoreUserDataRepo.getByUserId если нет данных", () async {
      var userData = await repo.getByUserId("ass");

      expect(userData, null);
    });
  });
}
