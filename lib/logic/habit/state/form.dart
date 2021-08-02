import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/notifications/daily.dart';

import '../models.dart';

/// Стейт формочки привычки
class HabitFormState extends StateNotifier<Habit> {
  /// Сервис для отправки напоминалок
  final HabitPerformNotificationService habitPerformNotificationService;

  /// Стейт формочки привычки
  HabitFormState(Habit state, this.habitPerformNotificationService)
      : super(state);

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
    await habitPerformNotificationService.remove(state.notification!.id);
    state = state.copyWith(notification: null);
  }

  /// Высталяет уведомление
  Future setNotification(DateTime atDateTime) async {
    if (state.notification != null) {
      habitPerformNotificationService.remove(state.notification!.id);
    }

    var notificationId = await habitPerformNotificationService.create(
      state,
      atDateTime,
      repeatWeekly: state.frequencyType == HabitFrequencyType.weekly,
    );
    state = state.copyWith(
      notification: HabitNotificationSettings(
        id: notificationId,
        time: atDateTime,
      ),
    );
  }
}

/// Провайдер стейта формы привычки
StateNotifierProvider<HabitFormState, Habit> habitFormStateProvider =
    StateNotifierProvider<HabitFormState, Habit>(
  (ref) => HabitFormState(
    Habit.blank(userId: FirebaseAuth.instance.currentUser!.uid),
    ref.read(habitPerformNotificationServiceProvider),
  ),
);
