import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../core/ui/deps.dart';
import '../../../core/utils/async_value.dart';
import '../../../core/utils/dt.dart';
import '../../../settings/ui/core/deps.dart';
import '../../domain/db.dart';
import '../../domain/models.dart';
import '../../domain/services.dart';
import '../../infra/db.dart';
import '../calendar/controllers.dart';
import '../details/view_models.dart';
import 'controllers.dart';
import 'view_models.dart';

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
    settings: ref.watch(settingsProvider).state,
  ),
);

////////////////////////////////////////////////////////////////////////////////
// HABIT LIST PAGE
////////////////////////////////////////////////////////////////////////////////

StateProvider<DateTime> selectedDateProvider =
    StateProvider((ref) => DateTime.now().date());

/// Провайдер ВМок для страницы со списком привычек
Provider<AsyncValue<List<HabitProgressVM>>> listHabitVMs = Provider(
  (ref) => ref
      .watch(habitControllerProvider.state)
      .merge2(ref.watch(habitPerformingController.state))
      .whenData((habitsAndPerformings) {
    var habits = habitsAndPerformings.item1;
    var dateHabitPerformings = habitsAndPerformings.item2;

    var selectedDate = ref.watch(selectedDateProvider).state;
    var settings = ref.watch(settingsProvider).state;

    var groupedHabitPerformings = groupBy<HabitPerforming, String>(
        dateHabitPerformings[selectedDate] ?? [], (hp) => hp.habitId);

    return habits
        .where((h) => h.matchDate(selectedDate))
        .map((h) =>
            HabitProgressVM.build(h, groupedHabitPerformings[h.id] ?? []))
        .where((h) => settings.showCompleted || !h.isComplete && !h.isExceeded)
        .toList()
          ..sort((h1, h2) => h1.performTime == null
              ? (h2.performTime == null ? 0 : 1)
              : (h2.performTime == null
                  ? -1
                  : h1.performTime.compareTo(h2.performTime)));
  }),
);

////////////////////////////////////////////////////////////////////////////////
// HABIT DETAILS PAGE
////////////////////////////////////////////////////////////////////////////////

StateProvider<String> selectedHabitIdProvider = StateProvider((ref) => null);

/// Дейтренж текущего дня
Provider<DateRange> todayDateRange = Provider((ref) {
  var settings = ref.watch(settingsProvider).state;

  return DateRange.fromDateAndTimes(
    DateTime.now(),
    settings.dayStartTime,
    settings.dayEndTime,
  );
});

/// Провайдер ВМ страницы деталей привычки
Provider<AsyncValue<HabitDetailsPageVM>> habitDetailsPageVMProvider = Provider(
  (ref) => ref
      .watch(habitControllerProvider.state)
      .merge2(ref.watch(habitPerformingController.state))
      .whenData((habitsAndPerformings) {
    var habits = habitsAndPerformings.item1;
    var performings = habitsAndPerformings.item2;

    var selectedHabitId = ref.watch(selectedHabitIdProvider).state;
    var selectedHabit = habits.firstWhere(
      (h) => h.id == selectedHabitId,
      orElse: () => null,
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
    habitRepo: ref.watch(habitRepoProvider),
  ),
);

/// Провайдер стейта анимированного списка на странице календаря
StateNotifierProvider<HabitCalendarPage_AnimatedListState>
    // ignore: non_constant_identifier_names
    habitCalendarPage_AnimatedListState_Provider = StateNotifierProvider(
  (ref) => HabitCalendarPage_AnimatedListState(GlobalKey<AnimatedListState>()),
);
