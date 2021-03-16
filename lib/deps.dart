import 'package:cloud_firestore/cloud_firestore.dart'
    show CollectionReference, FirebaseFirestore;
import 'package:collection/collection.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:tuple/tuple.dart';

import 'core/infra/push.dart';
import 'core/utils/dt.dart';
import 'logic/habit/domain/db.dart';
import 'logic/habit/domain/models.dart';
import 'logic/habit/domain/services.dart';
import 'logic/habit/infra/db.dart';
import 'logic/habit/ui/core/controllers.dart';
import 'logic/habit/ui/core/view_models.dart';
import 'logic/habit/ui/details/view_models.dart';
import 'settings/domain/models.dart';
import 'user/domain/db.dart';
import 'user/domain/services.dart';
import 'user/infra/db.dart';
import 'user/ui/controllers.dart';

////////////////////////////////////////////////////////////////////////////////
/// ОБЩЕЕ
////////////////////////////////////////////////////////////////////////////////

// region

/// Регает индекс выбранной странички
StateProvider<int> pageIndexProvider = StateProvider((_) => 0);

/// Плагин для отправки локальных пушей
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Регает плагин для отправки локальных пушей
Provider<FlutterLocalNotificationsPlugin>
    flutterLocalNotificationsPluginProvider =
    Provider((_) => flutterLocalNotificationsPlugin);

/// Провайдер отправщика уведомлений
Provider<NotificationSender> notificationSenderProvider = Provider(
  (ref) =>
      NotificationSender(ref.watch(flutterLocalNotificationsPluginProvider)),
);

/// АЙдишник открытой странички
/// Используется для получения контекста страницы, после вызова Navigator.pop
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Инфа о приложении
late PackageInfo packageInfo;

/// Инфа о девайсе
late AndroidDeviceInfo androidInfo;

/// Провайдер версии
Provider<String> versionProvider =
    Provider((ref) => "${packageInfo.version}+${packageInfo.buildNumber}");

// endregion

////////////////////////////////////////////////////////////////////////////////
/// ЮЗЕР
////////////////////////////////////////////////////////////////////////////////

// region

/// Провайдер аутентификации
Provider<Auth> authProvider = Provider((_) => Auth());

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

// endregion

////////////////////////////////////////////////////////////////////////////////
/// ПРИВЫЧКИ
////////////////////////////////////////////////////////////////////////////////

// region

Provider<TryDeletePendingNotification> tryDeletePendingNotification = Provider(
  (ref) => TryDeletePendingNotification(ref.watch(notificationSenderProvider)),
);

/// Провайдер ссылки на фаер-стор коллекцию с привычками
Provider<CollectionReference> habitCollectionRefProvider = Provider(
  (_) => FirebaseFirestore.instance.collection("habits"),
);

/// Провайдер ссылки на фаер-стор коллекцию с выполнениями привычек
Provider<CollectionReference> habitPerformingCollectionRefProvider = Provider(
  (_) => FirebaseFirestore.instance.collection("habit_performings"),
);

/// Регает репо привычек
Provider<BaseHabitRepo> habitRepoProvider = Provider(
    (ref) => FirestoreHabitRepo(ref.watch(habitCollectionRefProvider)));

/// Регает репо выполнений привычек
Provider<BaseHabitPerformingRepo> habitPerformingRepoProvider = Provider(
  (ref) => FireStoreHabitPerformingRepo(
      ref.watch(habitPerformingCollectionRefProvider)),
);

/// Провайдер функции планирования уведомл. о выполнении привычки
Provider<ScheduleSingleHabitNotification>
    schedulePerformHabitNotificationsProvider = Provider(
  (ref) => ScheduleSingleHabitNotification(
    notificationSender: ref.watch(notificationSenderProvider),
  ),
);

/// Провайдер привязки привычки к данным юзера
Provider<Future<void> Function(Habit habit)> addHabitToUserProvider =
    Provider((ref) => ref.watch(userDataControllerProvider).addHabit);

/// Провайдер CreateOrUpdateHabit
Provider<CreateOrUpdateHabit> createOrUpdateHabitProvider = Provider(
  (ref) => CreateOrUpdateHabit(
    habitRepo: ref.watch(habitRepoProvider),
    scheduleSingleHabitNotification:
        ref.watch(schedulePerformHabitNotificationsProvider),
    addHabitToUser: ref.watch(addHabitToUserProvider),
  ),
);

/// Провайдер TryDeletePendingNotification
Provider<TryDeletePendingNotification> tryDeletePendingNotificationProvider =
    Provider((ref) =>
        TryDeletePendingNotification(ref.watch(notificationSenderProvider)));

/// Провайдер DeleteHabit
Provider<DeleteHabit> deleteHabitProvider = Provider((ref) => DeleteHabit(
      habitRepo: ref.watch(habitRepoProvider),
      tryDeletePendingNotification:
          ref.watch(tryDeletePendingNotificationProvider),
    ));

/// Провайдер айди привычек юзера
Provider<List<String>> userHabitIdsProvider =
    Provider((ref) => ref.watch(userDataControllerProvider.state)!.habitIds);

/// Провайдер LoadUserHabits
Provider<LoadUserHabits> loadUserHabitsProvider = Provider(
  (ref) => LoadUserHabits(
    habitRepo: ref.watch(habitRepoProvider),
  ),
);

/// Провайдер контроллера привычек
StateNotifierProvider<HabitController> habitControllerProvider =
    StateNotifierProvider(
  (ref) => HabitController(
    createOrUpdateHabit: ref.watch(createOrUpdateHabitProvider),
    deleteHabit: ref.watch(deleteHabitProvider),
    loadUserHabits: ref.watch(loadUserHabitsProvider),
  ),
);

/// Провайдер настроек
Provider<Settings> settingsProvider =
    Provider((ref) => ref.watch(userDataControllerProvider.state)!.settings);

/// Провайдер настроек начачла и конца дня
Provider<Tuple2<DateTime, DateTime>> settingsDayTimesProvider = Provider((ref) {
  var settings = ref.watch(settingsProvider);
  return Tuple2(settings.dayStartTime, settings.dayEndTime);
});

/// Провайдер контроллера выполнений привычек
StateNotifierProvider<HabitPerformingController> habitPerformingController =
    StateNotifierProvider(
  (ref) => HabitPerformingController(
      repo: ref.watch(habitPerformingRepoProvider),
      settingsDayTimes: ref.watch(settingsDayTimesProvider)),
);

/// Провайдер выбранной даты
StateProvider<DateTime> selectedDateProvider =
    StateProvider((ref) => DateTime.now().date());

/// Провайдер ВМок для страницы со списком привычек
Provider<AsyncValue<List<HabitProgressVM>>> listHabitVMsProvider = Provider(
  (ref) => ref
      .watch(habitPerformingController.state)
      .whenData((dateHabitPerformings) {

    var habits = ref.watch(habitControllerProvider.state);

    var selectedDate = ref.watch(selectedDateProvider).state;
    var settings = ref.watch(settingsProvider);

    var groupedHabitPerformings = groupBy<HabitPerforming, String>(
        dateHabitPerformings[selectedDate] ?? [], (hp) => hp.habitId);

    var vms = habits
        .where((h) => h.matchDate(selectedDate))
        .map((h) =>
        HabitProgressVM.build(h, groupedHabitPerformings[h.id] ?? []))
        .where((h) => settings.showCompleted || !h.isComplete && !h.isExceeded)
        .toList()
      ..sort((h1, h2) => h1.performTime == null
          ? (h2.performTime == null ? 0 : 1)
          : (h2.performTime == null
          ? -1
          : h1.performTime!.compareTo(h2.performTime!)));

    return vms;
  }),
);

/// Провайдер айди выбранной привычки
StateProvider<String?> selectedHabitIdProvider = StateProvider((ref) => null);

/// Дейтренж текущего дня
Provider<DateRange> todayDateRange = Provider((ref) {
  var settings = ref.watch(settingsProvider);

  return DateRange.fromDateAndTimes(
    DateTime.now(),
    settings.dayStartTime,
    settings.dayEndTime,
  );
});

/// Провайдер ВМ страницы деталей привычки
Provider<AsyncValue<HabitDetailsPageVM>> habitDetailsPageVMProvider = Provider(
  (ref) => ref.watch(habitPerformingController.state).whenData((performings) {
    var habits = ref.watch(habitControllerProvider.state);

    var selectedHabitId = ref.watch(selectedHabitIdProvider).state;
    var selectedHabit = habits.firstWhere(
      (h) => h.id == selectedHabitId,
    );
    var selectedHabitPerformings = performings.map(
      (key, value) => MapEntry(
        key,
        value.where((hp) => hp.habitId == selectedHabitId).toList(),
      ),
    );

    var todaySelectedHabitPerformings =
        selectedHabitPerformings[ref.watch(todayDateRange).date] ?? [];
    var progress = HabitProgressVM.build(
      selectedHabit,
      todaySelectedHabitPerformings,
    );

    var history = HabitHistory.fromMap(selectedHabitPerformings);

    return HabitDetailsPageVM(
      habit: selectedHabit,
      progress: progress,
      history: history,
    );
  }),
);

/// Провайдер функции планирования уведомл. для привычек
/// без запланированных уведомл.
Provider<ScheduleNotificationsForHabitsWithoutNotifications>
    scheduleNotificationsForHabitsWithoutNotificationsProvider = Provider(
  (ref) => ScheduleNotificationsForHabitsWithoutNotifications(
    notificationSender: ref.watch(notificationSenderProvider),
  ),
);

// endregion
