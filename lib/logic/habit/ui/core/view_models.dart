import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/user/ui/controllers.dart';

import '../../domain/models.dart';
import 'controllers.dart';

part 'view_models.freezed.dart';

/// Вью-моделька прогресса привычки
@freezed
class HabitProgressVM with _$HabitProgressVM {
  const HabitProgressVM._();

  /// Вью-моделька прогресса привычки
  factory HabitProgressVM({
    required String id,

    /// Название
    required String title,

    /// Текущее значение (4 раза из 10)
    @Default(0) double currentValue,

    /// Целевое значение (10 раз)
    required double goalValue,

    /// Время выполнения
    DateTime? performTime,

    /// Тип
    required HabitType type,
  }) = _HabitProgressVM;

  /// Создает вм из привычки
  factory HabitProgressVM.build(
    Habit habit, [
    List<HabitPerforming>? habitPerformings,
  ]) =>
      HabitProgressVM(
        id: habit.id!,
        title: habit.title,
        type: habit.type,
        goalValue: habit.goalValue,
        currentValue: (habitPerformings ?? [])
            .map((p) => p.performValue)
            .fold(0, (v1, v2) => v1 + v2),
        performTime: habit.performTime,
      );

  /// Выполнена ли привычка
  bool get isComplete => currentValue.toInt() == goalValue.toInt();

  /// Перевыполнена ли привычка
  /// Напр. вместо 1 минуты, привычка выполнялась 2 минуты
  bool get isExceeded => currentValue > goalValue;

  /// Нужно ли выполнить привычку один раз
  bool get isSingle => type == HabitType.repeats && goalValue.toInt() == 1;

  /// Время выпалнения привычки в виде строки
  String get performTimeStr => formatTime(performTime!);
}

/// Статут выполнения привычки
enum HabitProgressStatus {
  /// Привычка не начинали делать
  none,

  /// Привычка частично выполнена
  partial,

  /// Привычка выполнена
  complete,

  /// Привычка перевыполнена
  exceed,
}

/// Создает прогресс на основе текущего и целевого значений
HabitProgressStatus buildHabitProgressStatus(
  double currentValue,
  double goalValue,
) {
  if (currentValue == 0) {
    return HabitProgressStatus.none;
  }
  if (currentValue < goalValue) {
    return HabitProgressStatus.partial;
  }
  if (currentValue == goalValue) {
    return HabitProgressStatus.complete;
  }
  if (currentValue > goalValue) {
    return HabitProgressStatus.exceed;
  }
  throw "Хз как быть с currentValue=$currentValue, goalValue=$goalValue";
}

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
