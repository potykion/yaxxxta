import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/notifications/daily.dart';

import '../models.dart';

/// Стейт формочки привычки
class HabitFormState extends StateNotifier<Habit> {
  /// Стейт формочки привычки
  HabitFormState(Habit state) : super(state);

  /// Сброс стейта
  void reset() {
    state = Habit.blank(userId: FirebaseAuth.instance.currentUser!.uid);
  }

  // ignore: use_setters_to_change_properties
  /// Обновляет стейт
  void update(Habit habit) {
    state = habit;
  }

  /// Удаляет уведомление
  Future removeNotification() async {
    await DailyHabitPerformNotifications.remove(state.notification!.id);
    state = state.copyWith(notification: null);
  }

  /// Высталяет уведомление
  Future setNotification(DateTime atDateTime) async {
    var notificationId = await DailyHabitPerformNotifications.create(
      state,
      atDateTime,
    );
    state = state.copyWith(
      notification: HabitNotificationSettings(
        id: notificationId,
        time: atDateTime,
      ),
    );
  }
}

StateNotifierProvider<HabitFormState, Habit> habitFormStateProvider =
    StateNotifierProvider<HabitFormState, Habit>(
  (_) => HabitFormState(
    Habit.blank(userId: FirebaseAuth.instance.currentUser!.uid),
  ),
);
