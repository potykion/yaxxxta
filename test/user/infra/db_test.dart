// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:yaxxxta/user/infra/db.dart';
// import 'package:yaxxxta/user/domain/models.dart';
//
// void main() {
//   group("Тестим FirestoreUserDataRepo", () {
//     FirebaseFirestore instance;
//     FirestoreUserDataRepo repo;
//
//     setUp(() {
//       instance = MockFirestoreInstance();
//       repo = FirestoreUserDataRepo(instance.collection('user_data'));
//     });
//
//     test("FirestoreUserDataRepo.create", () async {
//       await repo.create(UserData.blank(deviceId: 'ass'));
//       var insertedUserData = (await instance.collection("user_data").get())
//           .docs
//           .map((doc) => UserData.fromJson(doc.data()))
//           .first;
//
//       expect(insertedUserData, UserData.blank(deviceId: "ass"));
//     });
//
//     test("FirestoreUserDataRepo.getByDeviceId", () async {
//       await repo.create(UserData.blank(deviceId: 'ass'));
//
//       var userData = await repo.getByDeviceId("ass");
//
//       expect(userData, UserData.blank(deviceId: "ass"));
//     });
//
//     test("FirestoreUserDataRepo.getByDeviceId если нет данных", () async {
//       var userData = await repo.getByDeviceId("ass");
//
//       expect(userData, null);
//     });
//
//     test("FirestoreUserDataRepo.getByUserId", () async {
//       var initUserData = UserData.blank(deviceId: 'ass', userId: "tests");
//       await repo.create(initUserData);
//
//       var userData = await repo.getByUserId("tests");
//
//       expect(userData, initUserData);
//     });
//
//     test("FirestoreUserDataRepo.getByUserId если нет данных", () async {
//       var userData = await repo.getByUserId("ass");
//
//       expect(userData, null);
//     });
//   });
// }
