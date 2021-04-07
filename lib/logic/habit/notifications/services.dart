import 'package:yaxxxta/logic/core/utils/dt.dart';

import '../models.dart';
import 'db.dart';
import 'models.dart';

class DeletePendingNotifications {
  final HabitNotificationRepo _repo;

  DeletePendingNotifications(this._repo);

  Future<void> call(String habitId) async {
    var pending = (await _repo.getPending())
        .where((n) => n.habitId == habitId)
        .map((n) => n.id);
    await Future.wait(pending.map(_repo.cancel));
  }
}

class TryRescheduleHabitNotification {
  final HabitNotificationRepo habitNotificationRepo;
  final DeletePendingNotifications deletePendingNotifications;

  TryRescheduleHabitNotification({
    required this.habitNotificationRepo,
    required this.deletePendingNotifications,
  });

  Future<void> call(Habit habit, DateRange todayDateRange) async {
    if (habit.performTime == null) return;

    await deletePendingNotifications(habit.id!);

    var notificationDateTime = habit
        .nextPerformDateTime()
        .where((dt) => !todayDateRange.containsDateTime(dt))
        .first;

    var notification = HabitNotification.createPerformNotification(
      habit,
      notificationDateTime,
    );
    habitNotificationRepo.schedule(notification);
  }
}
