import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/logic/habit/models.dart';

import '../../theme.dart';

/// Инпут выбора дня недели
class HabitPerformWeekdayInput extends HookWidget {
  /// Начальный день недели
  final Weekday? initial;
  /// Событие выбора дня недели
  final void Function(Weekday weekday) change;

  /// Инпут выбора дня недели
  const HabitPerformWeekdayInput({
    required this.initial,
    required this.change,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = useState(initial);
    var selectedWeekday = state.value;
    setHabitFreqType(Weekday weekday) {
      state.value = weekday;
      change(weekday);
    }

    _buildHabitPerformWeekdayChip(Weekday weekday) {
      return ChoiceChip(
        padding: EdgeInsets.all(CorePaddings.smallest),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CoreBorderRadiuses.small),
        ),
        label: Text(weekday.toAbbrString()),
        selected: selectedWeekday == weekday,
        onSelected: (_) => setHabitFreqType(weekday),
        selectedColor: CoreColors.green,
        backgroundColor: CoreColors.lightGreen,
        labelStyle: TextStyle(
          color: CoreColors.darkPurple,
          fontSize: 16,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int index in List.generate(7, (index) => index))
          _buildHabitPerformWeekdayChip(Weekday.values[index]),
      ],
    );
  }
}
