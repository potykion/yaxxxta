import 'package:flutter/material.dart';

import '../../../core/ui/widgets/input.dart';
import '../../../theme.dart';
import '../../domain/models.dart';

/// Радио-групп типа привычки
class HabitTypeRadioGroup extends StatefulWidget {
  /// Начальный тип привычки
  final HabitType initial;

  /// Событие смены типа привычки
  final Function(HabitType habitType) change;

  /// Если true, то прячит остальные типы привычек
  final bool setBefore;

  /// Создает инпут
  const HabitTypeRadioGroup({
    Key? key,
    required this.initial,
    required this.change,
    this.setBefore = false,
  }) : super(key: key);

  @override
  _HabitTypeRadioGroupState createState() => _HabitTypeRadioGroupState();
}

class _HabitTypeRadioGroupState extends State<HabitTypeRadioGroup> {
  late HabitType selectedHabitType;

  @override
  void initState() {
    super.initState();
    selectedHabitType = widget.initial;
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (!widget.setBefore ||
              widget.setBefore && widget.initial == HabitType.repeats)
            buildHabitTypeRadio(HabitType.repeats),
          if (!widget.setBefore) SizedBox(height: 5),
          if (!widget.setBefore ||
              widget.setBefore && widget.initial == HabitType.time)
            buildHabitTypeRadio(HabitType.time),
        ],
      );

  Selectable buildHabitTypeRadio(HabitType habitType) {
    late String biggerText;
    late String smallerText;
    if (habitType == HabitType.time) {
      biggerText = "На время";
      smallerText = "Например, 10 мин. в день";
    }
    if (habitType == HabitType.repeats) {
      biggerText = "На повторы";
      smallerText = "Например, 2 раза в день";
    }

    return Selectable(
      biggerText: biggerText,
      smallerText: smallerText,
      initial: selectedHabitType == habitType,
      onSelected: (_) => changeHabitType(habitType),
      prefix: Radio<HabitType>(
        value: habitType,
        groupValue: selectedHabitType,
        onChanged: (_) => changeHabitType(habitType),
        activeColor: CustomColors.almostBlack,
      ),
    );
  }

  void changeHabitType(HabitType habitType) {
    setState(() => selectedHabitType = habitType);
    widget.change(selectedHabitType);
  }
}
