import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/notifications/daily.dart';

/// Стейт страницы календаря и привычек в целом
class HabitCalendarState extends StateNotifier<List<HabitVM>> {
  final FirebaseHabitRepo habitRepo;
  final FirebaseHabitPerformingRepo habitPerformingRepo;
  final HabitPerformNotificationService habitPerformNotificationService;

  /// Стейт страницы календаря и привычек в целом
  HabitCalendarState(
    this.habitRepo,
    this.habitPerformingRepo,
    this.habitPerformNotificationService, [
    List<HabitVM> state = const [],
  ]) : super(state);

  /// Загрузка стейта
  Future<void> load(String userId) async {
    var habits = await habitRepo.listByUserId(userId);
    var performings = groupBy<HabitPerforming, String>(
      await habitPerformingRepo.listSortedByCreatedAndFilterByUserId(userId),
      (hp) => hp.habitId,
    );
    state = habits
        .map(
          (h) => HabitVM(
            habit: h,
            performings: performings[h.id!] ?? [],
          ),
        )
        .toList();
  }

  /// Создание привычки
  Future<void> create(Habit habit) async {
    habit = habit.copyWith(id: await habitRepo.insert(habit));
    state = [...state, HabitVM(habit: habit)];
  }

  /// Обновление привычки
  Future<void> update(Habit habit) async {
    await habitRepo.update(habit);
    var habitToUpdate = state.where((vm) => vm.habit.id == habit.id).first;
    state = [
      ...state.where((vm) => vm.habit.id != habit.id),
      habitToUpdate.copyWith(habit: habit),
    ];
  }

  /// Выполнение привычки
  Future<void> perform(Habit habit, [DateTime? performDatetime]) async {
    performDatetime = performDatetime ?? DateTime.now();
    var performing = HabitPerforming.blank(
      habit.id!,
      habit.userId,
      performDatetime,
    );
    performing = performing.copyWith(
      id: await habitPerformingRepo.insert(performing),
    );

    /// Если дата выполнения сегодняшняя,
    /// то отменяем уведомление + создаем новое
    if (performDatetime.isToday() && habit.notification != null) {
      habit = await _rescheduleNotification(habit);
      await update(habit);
    }

    var vm = state.where((vm) => vm.habit.id == habit.id).first;
    state = [
      ...state.where((vm) => vm.habit.id != habit.id),
      vm.copyWith(performings: [...vm.performings, performing]),
    ];
  }

  /// Отменяет уведомление и назначает новое
  Future<Habit> _rescheduleNotification(Habit habit,
      {bool tomorrow = true}) async {
    habitPerformNotificationService.remove(habit.notification!.id);

    // Новая напоминалка создается на следующий день
    // (с учетом дня недели если указан)
    var atDateTime = TimeOfDay.fromDateTime(
      habit.notification!.time,
    ).toDateTime(
      now: DateTime.now().add(Duration(days: tomorrow ? 1 : 0)),
      weekday: habit.performWeekday,
    );

    var notificationId = await habitPerformNotificationService.create(
      habit,
      atDateTime,
    );
    habit = habit.copyWith(
      notification: HabitNotificationSettings(
        id: notificationId,
        time: atDateTime,
      ),
    );
    return habit;
  }

  /// Отправляет привычку в архив
  Future<void> archive(Habit habit) async {
    if (habit.notification != null) {
      habitPerformNotificationService.remove(habit.notification!.id);
    }

    await update(habit.copyWith(archived: true));
  }

  /// Удаляет привычку
  Future<void> delete(Habit habit) async {
    assert(habit.archived);
    await habitPerformingRepo.deleteById(habit.id!);
    state = [...state.where((vm) => vm.habit.id != habit.id!)];
  }

  /// Возвращает привычку из архива
  Future unarchive(Habit habit) async {
    habit = habit.copyWith(archived: false);
    if (habit.notification != null) {
      habit = await _rescheduleNotification(habit);
    }
    await update(habit);
  }

  /// Создает напоминалки для привычек, у которых они есть в бд,
  /// но они не запланированы
  /// Напр. при переустановке аппа
  Future scheduleNotificationsForHabitsWithoutNotifications() async {
    /// Берем все напоминалки
    var pendingNotificationIds =
        await habitPerformNotificationService.pending();

    /// Фильтруем привычки без напоминалок
    var habitsWithoutNotifications = state
        .map((vm) => vm.habit)
        .where((habit) => !habit.archived)
        .where((habit) => habit.notification != null)
        .where(
          (habit) => !pendingNotificationIds.contains(habit.notification!.id),
        );

    /// Для каждой такой привычки выставляем новую напоминалку
    for (var habit in habitsWithoutNotifications) {
      var newHabit = await _rescheduleNotification(habit, tomorrow: false);
      await update(newHabit);
    }
  }
}

/// Провайдер стейта страницы календаря
StateNotifierProvider<HabitCalendarState, List<HabitVM>>
    habitCalendarStateProvider =
    StateNotifierProvider<HabitCalendarState, List<HabitVM>>(
  (ref) => HabitCalendarState(
    ref.read(habitRepoProvider),
    ref.read(habitPerformingRepoProvider),
    ref.read(habitPerformNotificationServiceProvider),
  ),
);

/// Провайдер привычек
Provider<List<HabitVM>> habitVMsProvider = Provider(
  (ref) => ref
      .watch(habitCalendarStateProvider)
      .where((vm) => !vm.habit.archived)
      .toList()
        ..sort((vm1, vm2) => vm1.habit.order.compareTo(vm2.habit.order)),
);

/// Заархивированные привычки
Provider<List<HabitVM>> archivedHabitVMsProvider = Provider(
  (ref) => ref
      .watch(habitCalendarStateProvider)
      .where((vm) => vm.habit.archived)
      .toList(),
);
