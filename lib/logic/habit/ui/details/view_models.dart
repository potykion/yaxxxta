import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/ui/core/controllers.dart';
import 'package:yaxxxta/logic/user/ui/controllers.dart';

import '../../../core/utils/dt.dart';
import '../../models.dart';
import '../core/view_models.dart';

part 'view_models.freezed.dart';

/// ВМка для HabitDetailsPage
class HabitDetailsPageVM {
  /// Привычка
  final Habit habit;

  /// Прогресс привычки за текущий день
  final HabitProgressVM progress;

  /// История привычки
  final HabitHistory history;

  /// ВМка для HabitDetailsPage
  HabitDetailsPageVM({
    required this.habit,
    required this.progress,
    required this.history,
  });
}

/// История привычки
class HabitHistory {
  /// История привычки - мапа,
  /// где ключ - дата, значения - список записей об истории
  final Map<DateTime, List<HabitHistoryEntry>> history;

  /// История привычки
  HabitHistory(this.history);

  /// Создает из мапы
  factory HabitHistory.fromMap(Map<DateTime, List<HabitPerforming>> map) {
    return HabitHistory(
      map.map(
        (key, value) => MapEntry(
          key,

          /// Группируем выполнения по времени в рамках одной даты
          groupBy<HabitPerforming, DateTime>(
            value,
            (hp) => hp.performDateTime.time(date: hp.performDateTime),
          )
              .entries

              /// Создаем записи истории, суммируя значения выполнений
              .map(
                (e) => HabitHistoryEntry(
                  time: e.key,
                  value: e.value.fold(0, (sum, hp) => sum + hp.performValue),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  /// Получает историю выполнения привычек за дату
  List<HabitHistoryEntry> getForDate(DateTime date) =>
      history[date] ?? <HabitHistoryEntry>[];

  /// Хайлаты истории - мапа,
  /// где ключ - дата, значение была ли выполнения привычка в эту дату
  Map<DateTime, double> get highlights =>
      history.map((key, value) => MapEntry(key, value.isNotEmpty ? 1 : 0));
}

/// Запись о выполнении привычки
@freezed
class HabitHistoryEntry with _$HabitHistoryEntry {
  const HabitHistoryEntry._();

  /// Запись о выполнении привычки
  factory HabitHistoryEntry({
    /// Время
    required DateTime time,

    /// Изменеие значения привычки
    required double value,
  }) = _HabitHistoryEntry;

  /// Форматирует значение записи
  String format(HabitType type) => type == HabitType.time
      ? Duration(seconds: value.toInt()).format()
      : value.toInt().toString();
}

/// Провайдер айди выбранной привычки
StateProvider<String?> selectedHabitIdProvider = StateProvider((ref) => null);

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
