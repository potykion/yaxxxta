import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../habit/domain/models.dart';

import '../../../theme.dart';
import '../../utils/utils.dart';
import 'text.dart';

/// Инпут для ввода текста, чисел
class TextInput<T> extends StatefulWidget {
  /// Начальное значение инпута
  final T initial;

  /// Событие изменения значения инпута
  final void Function(dynamic value) change;

  /// Виджет, который показывать на конце инпута
  /// Например обозначения
  final Widget suffix;

  /// Создает инпут
  const TextInput({
    Key key,
    @required this.initial,
    @required this.change,
    this.suffix,
  }) : super(key: key);

  @override
  _TextInputState<T> createState() => _TextInputState<T>();
}

class _TextInputState<T> extends State<TextInput> {
  TextEditingController tec = TextEditingController();

  bool get isNumberInput => T == double || T == int;

  @override
  void initState() {
    super.initState();
    setTecValue();
    tec.addListener(
      () {
        if (isNumberInput) {
          var value = T == double
              ? (double.tryParse(tec.text) ?? 0.0)
              : (int.tryParse(tec.text) ?? 0);
          if (formatDouble(widget.initial as num) != formatDouble(value)) {
            widget.change(value);
          }
        } else {
          var value = tec.text;
          if (widget.initial != value) {
            widget.change(value);
          }
        }
      },
    );
  }

  @override
  void didUpdateWidget(covariant TextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    setTecValue();
  }

  void setTecValue() {
    if (isNumberInput) {
      tec.text = formatDouble(widget.initial as num);
    } else {
      tec.text = widget.initial.toString();
    }

    // ставим курсор в конец инпута
    tec.selection =
        TextSelection.fromPosition(TextPosition(offset: tec.text.length));
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: tec,
        decoration: InputDecoration(
          fillColor: CustomColors.lightGrey,
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          suffixIcon: widget.suffix,
          suffixIconConstraints: BoxConstraints(minHeight: 25, minWidth: 40),
        ),
        keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
        cursorColor: CustomColors.almostBlack,
        style: TextStyle(
          fontSize: 18,
          color: CustomColors.almostBlack,
        ),
      );
}

/// Виджет выбора из нескольких вариантов
class Selectable extends StatefulWidget {
  /// Большой текст
  final String biggerText;

  /// Маленький текст
  final String smallerText;

  /// Начальное значение выбранности
  final bool initial;

  /// Событие выбора или снятия выбора
  final Function(bool selected) onSelected;

  /// Виджет отображаемый перед выбором, например радио или чекбокс
  final Widget prefix;

  /// Цвет выбора
  final Color selectedColor;

  /// Цвет отсутствия выбора
  final Color unselectedColor;

  /// Создает выбор
  const Selectable({
    Key key,
    this.biggerText,
    this.smallerText,
    this.initial,
    this.onSelected,
    this.prefix,
    this.selectedColor = CustomColors.blue,
    this.unselectedColor = CustomColors.lightGrey,
  }) : super(key: key);

  @override
  _SelectableState createState() => _SelectableState();
}

class _SelectableState extends State<Selectable> {
  bool selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initial;
  }

  @override
  void didUpdateWidget(covariant Selectable oldWidget) {
    super.didUpdateWidget(oldWidget);
    selected = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: toggleSelected,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: selected ? widget.selectedColor : widget.unselectedColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Row(
              children: [
                if (widget.prefix != null) widget.prefix,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BiggerText(text: widget.biggerText),
                    if (widget.smallerText != null)
                      SmallerText(
                        text: widget.smallerText,
                        light: widget.selectedColor != widget.unselectedColor &&
                            selected,
                      )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void toggleSelected() {
    setState(() => selected = !selected);
    widget.onSelected(selected);
  }
}

/// Чекбоксик
class SelectableCheckbox extends HookWidget {
  /// Начальное значение выбора чекбокса
  final bool initial;

  /// Событие смены выбора чекбокса
  final Function(bool selected) change;

  /// Большой текст
  final String biggerText;

  /// Маленький текст
  final String smallerText;

  /// @nodoc
  SelectableCheckbox(
      {this.initial, this.change, this.biggerText, this.smallerText});

  @override
  Widget build(BuildContext context) {
    var selectedState = useState(initial);

    useValueChanged<bool, void>(
      selectedState.value,
      (_, __) => WidgetsBinding.instance.addPostFrameCallback(
        (_) => change(selectedState.value),
      ),
    );

    return Selectable(
      biggerText: biggerText,
      smallerText: smallerText,
      prefix: Checkbox(
        onChanged: (selected) => selectedState.value = selected,
        value: selectedState.value,
        activeColor: CustomColors.yellow,
        checkColor: CustomColors.almostBlack,
      ),
      initial: selectedState.value,
      onSelected: (selected) => selectedState.value = selected,
      selectedColor: Colors.white,
      unselectedColor: Colors.white,
    );
  }
}

/// Обычная кнопочка
class SimpleButton extends StatelessWidget {
  /// Текст кнопки
  final String text;

  /// Событие нажатия на кнопку
  final void Function() onTap;

  /// Создает кнопку
  const SimpleButton({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColors.yellow,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: BiggerText(text: text),
            ),
          ),
        ),
      );
}

/// Обычный чип
class SimpleChip extends StatelessWidget {
  /// Текст чипа
  final String text;

  /// Выбран ли чип
  final bool selected;

  /// Событие смены выбранности чипа
  final Function(bool selected) change;

  /// Цвет чипа
  final Color color;

  /// Отступы чипа
  final EdgeInsetsGeometry padding;

  /// Создает чип
  const SimpleChip({
    Key key,
    this.text,
    this.selected,
    this.change,
    this.color = CustomColors.red,
    this.padding = const EdgeInsets.all(10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selectedColor: color,
      label: Text(text, style: TextStyle(color: CustomColors.almostBlack)),
      onSelected: change,
      selected: selected,
      padding: padding,
    );
  }
}

/// Селект выбора типа периода привычки
class HabitPeriodTypeSelect extends StatefulWidget {
  /// Начальное значение типа периода привычки
  final HabitPeriodType initial;

  /// Событие смены типа периода привычки
  final Function(HabitPeriodType type) change;

  /// Создает селект
  const HabitPeriodTypeSelect(
      {Key key, @required this.initial, @required this.change})
      : super(key: key);

  @override
  _HabitPeriodTypeSelectState createState() => _HabitPeriodTypeSelectState();
}

class _HabitPeriodTypeSelectState extends State<HabitPeriodTypeSelect> {
  HabitPeriodType type;

  @override
  void initState() {
    super.initState();
    type = widget.initial;
  }

  @override
  Widget build(BuildContext context) =>
      DropdownButtonFormField<HabitPeriodType>(
        decoration: InputDecoration(
          fillColor: CustomColors.lightGrey,
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
        value: type,
        items:
            [HabitPeriodType.day, HabitPeriodType.week, HabitPeriodType.month]
                .map(
                  (pt) => DropdownMenuItem<HabitPeriodType>(
                    child: Text(pt.format()),
                    value: pt,
                  ),
                )
                .toList(),
        onChanged: (v) {
          setState(() => type = v);
          widget.change(v);
        },
      );
}

/// Пикер дней недели
class WeekdaysPicker extends StatefulWidget {
  /// Изначально выбранные дни недели
  final List<Weekday> initial;

  /// Событие изменения дней недели
  final Function(List<Weekday> w) change;

  /// Создает пикер
  const WeekdaysPicker({Key key, @required this.initial, @required this.change})
      : super(key: key);

  @override
  _WeekdaysPickerState createState() => _WeekdaysPickerState();
}

class _WeekdaysPickerState extends State<WeekdaysPicker> {
  List<Weekday> weekdays;

  @override
  void initState() {
    super.initState();
    weekdays = List.of(widget.initial);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: Weekday.values
          .map(
            (w) => SimpleChip(
              text: w.format(),
              selected: weekdays.contains(w),
              change: (selected) {
                setState(() {
                  if (selected) {
                    weekdays.add(w);
                  } else {
                    weekdays.remove(w);
                  }
                });
                widget.change(weekdays);
              },
              color: CustomColors.yellow,
              padding: EdgeInsets.all(5),
            ),
          )
          .toList(),
    );
  }
}
