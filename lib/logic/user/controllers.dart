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
  }) async {
    /// Если анон юзер => не юзаем фаербейз => берем первого юзера из бд
    /// Иначе по юзер айди
    var userData = user.isAnonymous
        ? await repo.first()
        : await repo.getByUserId(user.uid);

    /// Если нет UserData => анон юзер в первый раз =>
    /// создаем для девайса UserData
    if (userData == null) {
      userData = UserData.blank(userId: !user.isAnonymous ? user.uid : null);
      userData = userData.copyWith(id: await repo.insert(userData));
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

  /// Отвязывает привычку от юзера
  Future<void> removeHabit(String habitIdToDelete) async {
    assert(state != null);

    var userData = state!.copyWith(habitIds: [
      for (var habitId in state!.habitIds)
        if (habitId != habitIdToDelete) habitId
    ]);

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

/// Провайдер юзера
StateProvider<User?> userProvider = StateProvider<User?>((ref) => null);

/// Провайдер инфы о том, используется ли бесплатная версия приложения
/// true - юзер не авторизован или аноним
Provider<bool> isFreeProvider =
    Provider((ref) => ref.watch(userProvider).state?.isAnonymous ?? true);

/// Провайдер репо данных о юзере
Provider<UserDataRepo> userDataRepoProvider = Provider<UserDataRepo>(
  (ref) => ref.watch(isFreeProvider)
      ? ref.watch(hiveUserDataRepoProvider)
      : ref.watch(fbUserDataRepoProvider),
);

/// Провайдер контроллера данных о юзере
StateNotifierProvider<UserDataController, UserData?>
    userDataControllerProvider =
    StateNotifierProvider<UserDataController, UserData?>(
  (ref) => UserDataController(repo: ref.watch(userDataRepoProvider)),
);

/// Провайдер привязки привычки к данным юзера
Provider<Future<void> Function(Habit habit)> addHabitToUserProvider =
    Provider((ref) => ref.watch(userDataControllerProvider.notifier).addHabit);

/// Провайдер отвязки привычки к данным юзера
Provider<Future<void> Function(String habitId)> removeHabitFromUserProvider =
    Provider(
        (ref) => ref.watch(userDataControllerProvider.notifier).removeHabit);

/// Провайдер настроек
Provider<AppSettings> settingsProvider = Provider(
  (ref) =>
      ref.watch(userDataControllerProvider)?.settings ?? AppSettings.blank(),
);

/// Провайдер настроек начачла и конца дня
Provider<Tuple2<DateTime, DateTime>> settingsDayTimesProvider = Provider((ref) {
  var settings = ref.watch(settingsProvider);
  return Tuple2(settings.dayStartTime, settings.dayEndTime);
});

/// Дейтренж текущего дня
Provider<DateRange> todayDateRangeProvider = Provider((ref) {
  var times = ref.watch(settingsDayTimesProvider);
  return DateRange.fromDateAndTimes(
    DateTime.now(),
    times.item1,
    times.item2,
  );
});

/// Провайдер, который увеличивает кол-во баллов юзера
Provider<Future<void> Function([int points])>
    increaseUserPerformingPointsProvider = Provider(
  (ref) => ref
      .watch(userDataControllerProvider.notifier)
      .increaseUserPerformingPoints,
);
