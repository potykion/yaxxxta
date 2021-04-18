import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';

part 'vms.freezed.dart';

@freezed
abstract class HabitVM implements _$HabitVM {
  const HabitVM._();

  const factory HabitVM({
    required Habit habit,
    @Default(<HabitPerforming>[]) List<HabitPerforming> performings,
  }) = _HabitVM;

  bool get isPerformedToday =>
      performings.any((hp) => hp.created.date() == DateTime.now().date());
}
