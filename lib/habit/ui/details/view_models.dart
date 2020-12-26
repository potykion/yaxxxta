import 'package:yaxxxta/habit/domain/models.dart';
import 'package:yaxxxta/habit/ui/list/view_models.dart';
import '../../../core/utils/dt.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_models.freezed.dart';

@freezed
abstract class HabitDetailsVM with _$HabitDetailsVM {
  const HabitDetailsVM._();

  factory HabitDetailsVM({
    @nullable Habit habit,
    @nullable List<HabitPerforming> habitPerformings,
  }) = _HabitDetailsVM;

  /// История привычки - мапа, где ключ - дата,
  /// значение - список записей из времени и изменения прогресса
  Map<DateTime, List<HabitHistoryEntry>> get history => groupBy(
        habitPerformings,
        (HabitPerforming hp) => hp.performDateTime.date(),
      ).map(
        (key, value) => MapEntry(
          key,
          groupBy(value, (HabitPerforming hp) => hp.performDateTime.time())
              .entries
              .map(
                (e) => HabitHistoryEntry(
                  time: e.key.time(),
                  value: e.value.fold(0, (sum, hp) => sum + hp.performValue),
                ),
              )
              .toList(),
        ),
      );

  Map<DateTime, double> get historyHighlights =>
      history.map((key, value) => MapEntry(key, value.isNotEmpty ? 1 : 0));
}

/// Запись о выполнении привычки в прошлом
@freezed
abstract class HabitHistoryEntry with _$HabitHistoryEntry {
  const HabitHistoryEntry._();

  factory HabitHistoryEntry({
    /// Время
    DateTime time,

    /// Изменеие значения привычки
    double value,
  }) = _HabitHistoryEntry;

  /// Форматирует значение записи
  String format(HabitType type) => type == HabitType.time
      ? Duration(seconds: value.toInt()).format()
      : value.toInt().toString();
}
