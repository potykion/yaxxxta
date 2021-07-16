import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/logic/habit/models.dart';

import '../../theme.dart';

class HabitFrequencyTypeInput extends HookWidget {
  final HabitFrequencyType initial;
  final void Function(HabitFrequencyType habitFrequencyType) change;

  const HabitFrequencyTypeInput({
    required this.initial,
    required this.change,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var habitFreqTypeState = useState(initial);
    var habitFreqType = habitFreqTypeState.value;
    setHabitFreqType(HabitFrequencyType habitFreqType) {
      habitFreqTypeState.value = habitFreqType;
      change(habitFreqType);
    }

    _buildHabitFrequencyTypeChip(HabitFrequencyType chipType) {
      late String text;
      if (chipType == HabitFrequencyType.daily) {
        text = "Ежедневная";
      }
      if (chipType == HabitFrequencyType.weekly) {
        text = "Еженедельная";
      }

      return ChoiceChip(
        padding: EdgeInsets.all(CorePaddings.big),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CoreBorderRadiuses.small),
        ),
        label: Text(text),
        selected: habitFreqType == chipType,
        onSelected: (_) => setHabitFreqType(chipType),
        selectedColor: CoreColors.green,
        backgroundColor: CoreColors.lightGreen,
        labelStyle: TextStyle(
          color: CoreColors.darkPurple,
          fontSize: 16,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildHabitFrequencyTypeChip(HabitFrequencyType.daily),
        _buildHabitFrequencyTypeChip(HabitFrequencyType.weekly),
      ],
    );
  }
}
