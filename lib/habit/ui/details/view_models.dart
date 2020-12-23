import 'package:yaxxxta/habit/domain/models.dart';
import 'package:yaxxxta/habit/ui/list/view_models.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_models.freezed.dart';

@freezed
abstract class HabitDetailsVM with _$HabitDetailsVM {
  factory HabitDetailsVM(
    @nullable Habit habit,
    @nullable List<HabitPerforming> habitPerformings,
  ) = _HabitDetailsVM;
}

/// Запись о выполнении привычки в прошлом
class HabitHistoryEntry {
  /// Дата
  final DateTime datetime;

  /// Изменеие значения привычки
  final double value;

  /// Создает запись
  HabitHistoryEntry({this.datetime, this.value});

  /// Форматирует значение записи
  String format(HabitType type) =>
      HabitPerformValue(currentValue: value).format(type);
}
