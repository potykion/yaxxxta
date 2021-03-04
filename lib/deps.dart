import 'package:cloud_firestore/cloud_firestore.dart'
    show CollectionReference, FirebaseFirestore;
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:collection/collection.dart';

import 'core/infra/push.dart';
import 'core/utils/dt.dart';
import 'habit/domain/db.dart';
import 'habit/domain/models.dart';
import 'habit/domain/services.dart';
import 'habit/infra/db.dart';
import 'habit/ui/calendar/controllers.dart';
import 'habit/ui/core/controllers.dart';
import 'habit/ui/core/view_models.dart';
import 'habit/ui/details/view_models.dart';
import 'settings/domain/db.dart';
import 'settings/domain/models.dart';
import 'settings/infra/db.dart';
import 'settings/ui/core/controllers.dart';
import 'user/domain/db.dart';
import 'user/domain/services.dart';
import 'user/infra/db.dart';

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

/// Регает репо настроек
Provider<BaseSettingsRepo> settingsRepoProvider = Provider(
  (ref) => SharedPreferencesSettingsRepo(),
);

/// Регает настройки
StateProvider<Settings?> settingsProvider = StateProvider((ref) => null);

/// Провайдер котроллера настроек
Provider<SettingsController> settingsControllerProvider = Provider(
  (ref) => SettingsController(
    settingsState: ref.watch(settingsProvider),
    settingsRepo: ref.watch(settingsRepoProvider),
  ),
);

// endregion

////////////////////////////////////////////////////////////////////////////////
/// ЮЗЕР
////////////////////////////////////////////////////////////////////////////////

// region

/// Провайдер аутентификации
Provider<Auth> authProvider = Provider((_) => Auth());

Provider<UserDataRepo> userDataRepoProvider = Provider<UserDataRepo>(
  (_) =>
      FirestoreUserDataRepo(FirebaseFirestore.instance.collection("user_data")),
);

Provider<LoadUserData> loadUserDataProvider =
    Provider((ref) => LoadUserData(ref.watch(userDataRepoProvider)));

// endregion

////////////////////////////////////////////////////////////////////////////////
/// ПРИВЫЧКИ
////////////////////////////////////////////////////////////////////////////////

// region

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

/// Провайдер контроллера привычек
StateNotifierProvider<HabitController> habitControllerProvider =
    StateNotifierProvider(
  (ref) => HabitController(
    habitRepo: ref.watch(habitRepoProvider),
    deviceInfo: androidInfo,
    scheduleSingleHabitNotification:
        ref.watch(schedulePerformHabitNotificationsProvider),
    fbAuth: FirebaseAuth.instance,
  ),
);

/// Провайдер контроллера выполнений привычек
StateNotifierProvider<HabitPerformingController> habitPerformingController =
    StateNotifierProvider(
  (ref) => HabitPerformingController(
    repo: ref.watch(habitPerformingRepoProvider),
    settings: ref.watch(settingsProvider).state!,
  ),
);

StateProvider<DateTime> selectedDateProvider =
    StateProvider((ref) => DateTime.now().date());

/// Провайдер ВМок для страницы со списком привычек
Provider<AsyncValue<List<HabitProgressVM>>> listHabitVMs = Provider(
  (ref) => ref
      .watch(habitPerformingController.state)
      .whenData((dateHabitPerformings) {
    var habits = ref.watch(habitControllerProvider.state);

    var selectedDate = ref.watch(selectedDateProvider).state;
    var settings = ref.watch(settingsProvider).state;

    var groupedHabitPerformings = groupBy<HabitPerforming, String>(
        dateHabitPerformings[selectedDate] ?? [], (hp) => hp.habitId);

    return habits
        .where((h) => h.matchDate(selectedDate))
        .map((h) =>
            HabitProgressVM.build(h, groupedHabitPerformings[h.id] ?? []))
        .where((h) => settings!.showCompleted || !h.isComplete && !h.isExceeded)
        .toList()
          ..sort((h1, h2) => h1.performTime == null
              ? (h2.performTime == null ? 0 : 1)
              : (h2.performTime == null
                  ? -1
                  : h1.performTime!.compareTo(h2.performTime!)));
  }),
);

StateProvider<String?> selectedHabitIdProvider = StateProvider((ref) => null);

/// Дейтренж текущего дня
Provider<DateRange> todayDateRange = Provider((ref) {
  var settings = ref.watch(settingsProvider).state;

  return DateRange.fromDateAndTimes(
    DateTime.now(),
    settings!.dayStartTime,
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
        selectedHabitPerformings[ref.watch(todayDateRange).date];
    var progress = HabitProgressVM.build(
      selectedHabit,
      todaySelectedHabitPerformings!,
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

/// Провайдер стейта анимированного списка на странице календаря
StateNotifierProvider<HabitCalendarPage_AnimatedListState>
// ignore: non_constant_identifier_names
    habitCalendarPage_AnimatedListState_Provider = StateNotifierProvider(
  (ref) => HabitCalendarPage_AnimatedListState(GlobalKey<AnimatedListState>()),
);

// endregion
