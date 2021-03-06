import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/habit/domain/models.dart';
import 'package:yaxxxta/user/domain/db.dart';
import 'package:yaxxxta/user/domain/models.dart';

class UserDataController extends StateNotifier<UserData?> {
  final UserDataRepo repo;

  UserDataController({
    required this.repo,
    UserData? state,
  }) : super(state);

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

  Future<void> addHabit(Habit habit) async {
    assert(state != null);
    var userData =
        state!.copyWith(habitIds: {...state!.habitIds, habit.id!}.toList());
    await repo.update(userData);
    state = userData;
  }
}
