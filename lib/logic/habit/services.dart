import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:tuple/tuple.dart';
import 'package:yaxxxta/logic/core/push.dart';
import '../../deps.dart';
import 'db.dart';
import 'models.dart';

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

/// Планирует уведомления о выполнении привычки для всех привычек,
/// у которых нет запланированных уведомлений
class ScheduleNotificationsForHabitsWithoutNotifications {
  /// Отправщик уведомлений
  final NotificationSender notificationSender;

  /// Планирует уведомления о выполнении привычки для всех привычек,
  /// у которых нет запланированных уведомлений
  ScheduleNotificationsForHabitsWithoutNotifications({
    required this.notificationSender,
  });

  /// Планирует уведомления о выполнении привычки для всех привычек,
  /// у которых нет запланированных уведомлений
  Future<void> call(List<Habit> habits, {DateTime? now}) async {
    now = now ?? DateTime.now();

    //  Берем все привычки со временем выполнения и флагом отправки уведомления
    habits = habits
        .where((h) => h.isNotificationsEnabled && h.performTime != null)
        .toList();

    //  Берем все пендинг уведомления
    var allPendingNotifications = await notificationSender.getAllPending();

    //  Фильтруем привычки, у которых нет уведомлений
    var notificationHabitIds = allPendingNotifications
        .where((n) => n.payload != null && n.payload!.isNotEmpty)
        .map((n) => jsonDecode(n.payload!)["habitId"] as String)
        .toSet();
    var habitsWithoutNotifications =
        habits.where((h) => !notificationHabitIds.contains(h.id)).toList();

    //  Для каждой привычки скедулим некст уведомление
    await Future.wait(
      habitsWithoutNotifications.map(
        (habit) => notificationSender.schedule(
          title: habit.title,
          body: "Пора выполнить привычку",
          sendAfterSeconds:
              habit.nextPerformDateTime(now!).first.difference(now).inSeconds,
          payload: jsonEncode({"habitId": habit.id}),
        ),
      ),
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
    var allPendingNotifications = await notificationSender.getAllPending();
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
  final BaseHabitRepo habitRepo;

  /// Попытка удалить запланированное уведомление о привычке
  final TryDeletePendingNotification tryDeletePendingNotification;

  /// Удаляет привычку
  DeleteHabit({
    required this.habitRepo,
    required this.tryDeletePendingNotification,
  });

  /// Удаляет привычку + удаляет уведомление
  Future<void> call(String habitId) async {
    tryDeletePendingNotification(habitId);
    await habitRepo.deleteById(habitId);
  }
}

/// Создает или обновляет привычку
class CreateOrUpdateHabit {
  /// Репо привычек
  final BaseHabitRepo habitRepo;

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
  final BaseHabitRepo habitRepo;

  /// Грузит привычки юзера
  LoadUserHabits({
    required this.habitRepo,
  });

  /// Грузит привычки юзера
  Future<List<Habit>> call(List<String> userHabitIds) async =>
      await habitRepo.listByIds(userHabitIds);
}

/// Создает выполнение привычки
class CreateHabitPerforming {
  /// Репо выполнений привычек
  final BaseHabitPerformingRepo hpRepo;

  /// Настройки начала и конца дня
  final Tuple2<DateTime, DateTime> settingsDayTimes;

  /// Начисление баллов юзеру
  final Future<void> Function() increaseUserPerformingPoints;

  /// Создает выполнение привычки
  CreateHabitPerforming({
    required this.hpRepo,
    required this.settingsDayTimes,
    required this.increaseUserPerformingPoints,
  });

  /// Создает выполнение привычки +
  /// начисляет баллы юзеру, если привычка выполняется впервые за день
  Future<HabitPerforming> call(HabitPerforming hp) async {
    var date = hp.performDateTime.date();
    var dateRange = DateRange.fromDateAndTimes(
      date,
      settingsDayTimes.item1,
      settingsDayTimes.item2,
    );
    var dateHPExists = await hpRepo.checkHabitPerformingExistInDateRange(
      hp.habitId,
      dateRange.from,
      dateRange.to,
    );

    hp = hp.copyWith(id: await hpRepo.insert(hp));

    if (!dateHPExists) {
      await increaseUserPerformingPoints();
    }

    return hp;
  }
}

/// Провайдер функции планирования уведомл. для привычек
/// без запланированных уведомл.
Provider<ScheduleNotificationsForHabitsWithoutNotifications>
    scheduleNotificationsForHabitsWithoutNotificationsProvider = Provider(
  (ref) => ScheduleNotificationsForHabitsWithoutNotifications(
    notificationSender: ref.watch(notificationSenderProvider),
  ),
);

// endregion