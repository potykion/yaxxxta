import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/notifications/daily.dart';

import '../models.dart';

class HabitFormState extends StateNotifier<Habit> {
  HabitFormState(Habit state) : super(state);

  void reset() {
    state = Habit.blank(userId: FirebaseAuth.instance.currentUser!.uid);
  }

  // ignore: use_setters_to_change_properties
  void update(Habit habit) {
    state = habit;
  }

  Future removeNotification() async {
    await DailyHabitPerformNotifications.remove(state.notification!.id);
    state = state.copyWith(notification: null);
  }

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
