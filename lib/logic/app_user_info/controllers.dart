import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'db.dart';
import 'models.dart';

/// Стейт инфы о юзере
class AppUserInfoController extends StateNotifier<AppUserInfo> {
  final FirebaseAppUserInfoRepo repo;

  /// Стейт инфы о юзере
  AppUserInfoController(
    this.repo,
    AppUserInfo state,
  ) : super(state);

  /// Грузит инфу о юзере
  Future<void> load(String userId) async {
    state = (await repo.listByUserId(userId)).firstOrNull ?? state;
  }

  /// Создает иои обновляет инфу о юзере
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

/// Провайдер инфы о юзере
StateNotifierProvider<AppUserInfoController, AppUserInfo>
    appUserInfoControllerProvider =
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

/// Провайдер инфа о подписке
StateProvider<ProductDetails?> subscriptionProductProvider =
    StateProvider<ProductDetails?>((_) => null);
