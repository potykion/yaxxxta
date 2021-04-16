import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaxxxta/logic/habit/models.dart';

part 'vms.freezed.dart';

@freezed
abstract class HabitVM with _$HabitVM {
  const factory HabitVM({
    required Habit habit,
    @Default(<HabitPerforming>[]) List<HabitPerforming> performings,
  }) = _HabitVM;
}
