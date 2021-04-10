import 'dart:convert';

import 'package:flutter_local_notifications_platform_interface/src/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yaxxxta/logic/core/push.dart';
import '../../../deps.dart';
import '../db.dart';
import '../models.dart';

/// Планирует уведомление о выполнении привычки
class ScheduleSingleHabitNotification {
  /// Отправщик уведомлений
  final NotificationSender notificationSender;

  /// Планирует уведомление о выполнении привычки
  ScheduleSingleHabitNotification({
    required this.notificationSender,
  });

  /// Планирует уведомление о выполнении привычки
  Future<void> call({required Habit habit, bool resetPending = false}) async {
    if (resetPending) {
      var allPendingNotifications = await notificationSender.getAllPending();
      var habitPendingNotifications = allPendingNotifications.where(
        (n) =>
            n.payload != null &&
            n.payload!.isNotEmpty &&
            jsonDecode(n.payload!)["habitId"] == habit.id,
      );
      await Future.wait(
        habitPendingNotifications.map((n) => notificationSender.cancel(n.id)),
      );
    }

    notificationSender.schedule(
      title: habit.title,
      body: "Пора выполнить привычку",
      sendAfterSeconds: habit
          .nextPerformDateTime()
          .first
          .difference(DateTime.now())
          .inSeconds,
      payload: jsonEncode({"habitId": habit.id}),
      repeatDaily:
          habit.periodType == HabitPeriodType.day && habit.periodValue == 1,
      repeatWeekly: habit.periodType == HabitPeriodType.week &&
          habit.periodValue == 1 &&
          habit.performWeekdays.length == 1,
    );
  }
}


/// Попытка удалить запланированное уведомление о привычке
class TryDeletePendingNotification {
  /// Отправщик уведомлений
  final NotificationSender notificationSender;

  /// Попытка удалить запланированное уведомление о привычке
  TryDeletePendingNotification(this.notificationSender);

  /// Попытка удалить запланированное уведомление о привычке
  Future<void> call(String habitId) async {
    List<PendingNotificationRequest> allPendingNotifications = await notificationSender.getAllPending();
    try {
      var habitPendingNotification = allPendingNotifications
          .where((n) => jsonDecode(n.payload!)["habitId"] == habitId)
          .first;
      notificationSender.cancel(habitPendingNotification.id);
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {}
  }
}

/// Удаляет привычку
class DeleteHabit {
  /// Репо привычек
  final HabitRepo habitRepo;

  /// Отвязывает привычку от юзера
  final Future<void> Function(String habitId) removeHabitFromUser;

  /// Попытка удалить запланированное уведомление о привычке
  final TryDeletePendingNotification tryDeletePendingNotification;

  /// Удаляет привычку
  DeleteHabit({
    required this.habitRepo,
    required this.removeHabitFromUser,
    required this.tryDeletePendingNotification,
  });

  /// Удаляет привычку + удаляет уведомление
  Future<void> call(String habitId) async {
    tryDeletePendingNotification(habitId);
    await removeHabitFromUser(habitId);
    await habitRepo.deleteById(habitId);
  }
}

/// Создает или обновляет привычку
class CreateOrUpdateHabit {
  /// Репо привычек
  final HabitRepo habitRepo;

  /// Планирование оправки уведомл.
  final ScheduleSingleHabitNotification scheduleSingleHabitNotification;

  /// Привязывает привычку к юзеру
  final Future<void> Function(Habit habit) addHabitToUser;

  /// Создает или обновляет привычку
  CreateOrUpdateHabit({
    required this.habitRepo,
    required this.scheduleSingleHabitNotification,
    required this.addHabitToUser,
  });

  /// Создает или обновляет привычку
  Future<Tuple2<Habit, bool>> call(Habit habit) async {
    late bool created;
    if (habit.isUpdate) {
      await habitRepo.update(habit);
      created = false;
    } else {
      habit = habit.copyWith(id: await habitRepo.insert(habit));
      await addHabitToUser(habit);
      created = true;
    }

    if (habit.isNotificationsEnabled) {
      await scheduleSingleHabitNotification(
        habit: habit,
        resetPending: habit.isUpdate,
      );
    }

    return Tuple2(habit, created);
  }
}

/// Грузит привычки юзера
class LoadUserHabits {
  /// Репо привычек
  final HabitRepo habitRepo;

  /// Грузит привычки юзера
  LoadUserHabits({
    required this.habitRepo,
  });

  /// Грузит привычки юзера
  Future<List<Habit>> call(List<String> userHabitIds) async =>
      await habitRepo.listByIds(userHabitIds);
}


// endregion
