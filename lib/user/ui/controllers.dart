import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../habit/domain/models.dart';
import '../../settings/domain/models.dart';
import '../domain/db.dart';
import '../domain/models.dart';

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
      await repo.create(userData);
    }

    state = userData;
  }

  /// Обновляет настройки
  Future<void> updateSettings(Settings settings) async {
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

  /// Айди привычек, привязанных к юзеру
  List<String> get habitIds => state!.habitIds;
}