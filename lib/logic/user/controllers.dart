import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/reward/models.dart';

import 'db.dart';
import 'models.dart';

/// Контроллер данных о юзере
class UserDataController extends StateNotifier<UserData?> {
  /// Репо данных о юзере
  final UserDataRepo repo;

  /// Контроллер данных о юзере
  UserDataController({
    required this.repo,
    UserData? state,
  }) : super(state);

  /// Грузит данные о юзеере
  Future<void> load({
    required User user,
    required String deviceId,
  }) async {
    /// Если анон юзер => берем по девайсу
    /// Иначе по юзер айди
    var userData = user.isAnonymous
        ? await repo.getByDeviceId(deviceId)
        : await repo.getByUserId(user.uid);

    /// Если нет UserData => анон юзер в первый раз =>
    /// создаем для девайса UserData
    if (userData == null) {
      userData = UserData.blank(deviceId: deviceId);
      userData = userData.copyWith(id: await repo.create(userData));
    }

    state = userData;
  }

  /// Обновляет настройки
  Future<void> updateSettings(AppSettings settings) async {
    assert(state != null);
    var newUserData = state!.copyWith(settings: settings);
    await repo.update(newUserData);
    state = newUserData;
  }

  /// Привязывает привычку к данным юзера
  Future<void> addHabit(Habit habit) async {
    assert(state != null);
    var userData =
        state!.copyWith(habitIds: {...state!.habitIds, habit.id!}.toList());
    await repo.update(userData);
    state = userData;
  }

  /// Привязывает награду к данным юзера
  Future<void> addReward(Reward reward) async {
    assert(state != null);
    var userData =
        state!.copyWith(rewardIds: {...state!.rewardIds, reward.id!}.toList());
    await repo.update(userData);
    state = userData;
  }

  /// Уменьшает кол-во баллов юзера
  Future<void> decreasePerformingPoints(int points) async {
    assert(state != null);
    assert(state!.performingPoints >= points);
    var userData =
        state!.copyWith(performingPoints: state!.performingPoints - points);
    await repo.update(userData);
    state = userData;
  }

  /// Увеличивает кол-во баллов юзера
  Future<void> increaseUserPerformingPoints([int points = 1]) async {
    assert(state != null);
    var userData =
        state!.copyWith(performingPoints: state!.performingPoints + points);
    await repo.update(userData);
    state = userData;
  }
}

/// Провайдер репо данных о юзере
Provider<UserDataRepo> userDataRepoProvider = Provider<UserDataRepo>(
  (_) =>
      FirestoreUserDataRepo(FirebaseFirestore.instance.collection("user_data")),
);

/// Провайдер контроллера данных о юзере
StateNotifierProvider<UserDataController> userDataControllerProvider =
    StateNotifierProvider(
  (ref) => UserDataController(repo: ref.watch(userDataRepoProvider)),
);

/// Провайдер привязки привычки к данным юзера
Provider<Future<void> Function(Habit habit)> addHabitToUserProvider =
    Provider((ref) => ref.watch(userDataControllerProvider).addHabit);

/// Провайдер настроек
Provider<AppSettings> settingsProvider =
    Provider((ref) => ref.watch(userDataControllerProvider.state)!.settings);

/// Дейтренж текущего дня
Provider<DateRange> todayDateRange = Provider((ref) {
  var settings = ref.watch(settingsProvider);

  return DateRange.fromDateAndTimes(
    DateTime.now(),
    settings.dayStartTime,
    settings.dayEndTime,
  );
});

/// Провайдер настроек начачла и конца дня
Provider<Tuple2<DateTime, DateTime>> settingsDayTimesProvider = Provider((ref) {
  var settings = ref.watch(settingsProvider);
  return Tuple2(settings.dayStartTime, settings.dayEndTime);
});


/// Провайдер, который увеличивает кол-во баллов юзера
Provider<Future<void> Function([int points])>
    increaseUserPerformingPointsProvider = Provider(
  (ref) => ref.watch(userDataControllerProvider).increaseUserPerformingPoints,
);
