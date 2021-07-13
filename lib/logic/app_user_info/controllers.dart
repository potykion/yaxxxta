import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'db.dart';
import 'models.dart';

class AppUserInfoController extends StateNotifier<AppUserInfo> {
  final FirebaseAppUserInfoRepo repo;

  AppUserInfoController(
    this.repo,
    AppUserInfo state,
  ) : super(state);

  Future<void> load(String userId) async {
    state = (await repo.listByUserId(userId)).firstOrNull ?? state;
  }

  Future<void> insertOrUpdate(
      {required DateTime? subscriptionExpiration}) async {
    AppUserInfo appUserInfo = state.copyWith(
      subscriptionExpiration: subscriptionExpiration,
    );
    if (appUserInfo.id != null) {
      await repo.update(appUserInfo);
    } else {
      appUserInfo = appUserInfo.copyWith(id: await repo.insert(appUserInfo));
    }

    state = appUserInfo;
  }
}

StateNotifierProvider<AppUserInfoController, AppUserInfo> appUserInfoControllerProvider =
    StateNotifierProvider<AppUserInfoController, AppUserInfo>(
  (_) => AppUserInfoController(
    FirebaseAppUserInfoRepo(
      FirebaseFirestore.instance.collection("FirebaseAppUserInfoRepo"),
    ),
    AppUserInfo(
      userId: FirebaseAuth.instance.currentUser!.uid,
    ),
  ),
);

StateProvider<ProductDetails?> subscriptionProductProvider = StateProvider<ProductDetails?>((_) => null);
