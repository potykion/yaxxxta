import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:yaxxxta/push.dart';
import 'package:yaxxxta/routes.dart';

import 'models.dart';
import 'theme.dart';
import 'utils.dart';
import 'view_models.dart';

/// Карточка привычки
class HabitCard extends StatefulWidget {
  /// Вью-моделька привычки
  final HabitVM vm;

  /// Индекс повтора привычки в течение дня
  final int repeatIndex;

  /// Создает карточку
  const HabitCard({
    Key key,
    this.vm,
    this.repeatIndex,
  }) : super(key: key);

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  String get title => widget.vm.title;

  HabitRepeatVM get repeat => widget.vm.repeats[widget.repeatIndex];

  bool get isSingleRepeat => widget.vm.repeats.length == 1;

  String get repeatCounter =>
      "${widget.repeatIndex + 1} / ${widget.vm.repeats.length}";

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(Routes.form, arguments: widget.vm.id),
        child: PaddedContainerCard(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              BiggerText(text: title),
              SizedBox(width: 5),
              if (repeat.performTime != null)
                SmallerText(text: repeat.performTimeStr),
              Spacer(),
              if (!isSingleRepeat) SmallerText(text: repeatCounter)
            ],
          ),
          SizedBox(height: 5),
          HabitProgressControl(
            initialHabitRepeat: repeat,
          )
        ]),
      );
}

/// Карточка-контейнер с отступами
class PaddedContainerCard extends StatelessWidget {
  /// Дети :)
  /// Содержимое контейнера
  final List<Widget> children;

  /// Создает карточку
  const PaddedContainerCard({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      );
}

/// Ячейка выбора даты
class DatePickerItem extends StatelessWidget {
  /// Дата
  final DateTime date;

  /// Цвет
  final Color color;

  /// Создает ячейку
  const DatePickerItem({Key key, this.date, this.color = Colors.white})
      : super(key: key);

  String get _dateStr => "${date.day}.\n${date.month}";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        width: 50,
        child: Center(
          child: Text(
            _dateStr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

/// Выбор даты
class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  int selectedIndex = 0;

  /// Сдвигаем лист-вью на половину экрана + 3 паддинга по 10,
  /// чтобы текущий день был посерединке
  InfiniteScrollController controller = InfiniteScrollController(
    initialScrollOffset: -Get.mediaQuery.size.width / 2 + 3 * 10,
  );

  Random get random => Random();

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 60,
        child: InfiniteListView.builder(
          controller: controller,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: DatePickerItem(
              date: DateTime.now().add(Duration(days: index)),
              color: selectedIndex == index
                  ? CustomColors.yellow
                  : CustomColors.green.withAlpha(random.nextInt(255)),
            ),
          ),
        ),
      );
}

/// Контрол для изменения прогресса привычки
class HabitProgressControl extends StatefulWidget {
  /// Очередное выполнение привычки
  final HabitRepeatVM initialHabitRepeat;

  /// Создает контрол
  const HabitProgressControl({Key key, this.initialHabitRepeat})
      : super(key: key);

  @override
  _HabitProgressControlState createState() => _HabitProgressControlState();
}

class _HabitProgressControlState extends State<HabitProgressControl> {
  HabitRepeatVM habitRepeat;
  Timer timer;

  @override
  void initState() {
    super.initState();
    habitRepeat = widget.initialHabitRepeat;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Container(
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                value: habitRepeat.progressPercentage,
                backgroundColor: Color(0xffFAFAFA),
                valueColor: AlwaysStoppedAnimation<Color>(CustomColors.green
                    .withAlpha((habitRepeat.progressPercentage * 255).toInt())),
              ),
            ),
          ),
          Positioned(
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                splashRadius: 20,
                icon: habitRepeat.type == HabitType.time
                    ? (timer != null && timer.isActive
                        ? Icon(Icons.pause)
                        : Icon(Icons.play_arrow))
                    : Icon(Icons.done),
                onPressed: () {
                  // if (timer != null && timer.isActive) {
                  //   setState(() {
                  //     timer.cancel();
                  //   });
                  // } else {
                  //   setState(() =>
                  //       timer = Timer.periodic(Duration(seconds: 1), (timer) {
                  //         setState(() => habitRepeat.currentValue++);
                  //         if (habitRepeat.currentValue ==
                  //             habitRepeat.goalValue) {
                  //           Get.find<NotificationSender>()
                  //               .send(title: "Время закончилось!");
                  //           timer.cancel();
                  //         }
                  //       }));
                  // }
                },
              ),
            ),
          ),
          if (!habitRepeat.isSingle)
            Positioned(
              child: SmallerText(text: habitRepeat.progressStr, dark: true),
              right: 20,
            )
        ],
      );
}

/// Текст поменьше
class SmallerText extends StatelessWidget {
  /// Текст
  final String text;

  /// Темный текст (по умолчанию серый)
  final bool dark;

  /// Светлый текст (по умолчанию серый)
  final bool light;

  /// Создает текст
  const SmallerText({
    Key key,
    this.text,
    this.dark = false,
    this.light = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: dark
            ? CustomColors.almostBlack
            : light
                ? CustomColors.lightGrey
                : CustomColors.grey,
        fontSize: 14,
      ),
    );
  }
}

/// Текст побольше
class BiggerText extends StatelessWidget {
  /// Текст
  final String text;

  /// Создает текст
  const BiggerText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: CustomColors.almostBlack,
        ),
      );
}

/// Большуший текст
class BiggestText extends StatelessWidget {
  /// Текст
  final String text;

  /// Создает текст
  const BiggestText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: CustomColors.almostBlack,
        ),
      );
}

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
    Key key,
    @required this.initial,
    @required this.change,
    this.setBefore = false,
  }) : super(key: key);

  @override
  _HabitTypeRadioGroupState createState() => _HabitTypeRadioGroupState();
}

class _HabitTypeRadioGroupState extends State<HabitTypeRadioGroup> {
  HabitType selectedHabitType;

  @override
  void initState() {
    super.initState();
    selectedHabitType = widget.initial;
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (!widget.setBefore ||
              widget.setBefore && widget.initial == HabitType.time)
            buildHabitTypeRadio(HabitType.time),
          if (!widget.setBefore) SizedBox(height: 5),
          if (!widget.setBefore ||
              widget.setBefore && widget.initial == HabitType.repeats)
            buildHabitTypeRadio(HabitType.repeats),
        ],
      );

  Selectable buildHabitTypeRadio(HabitType habitType) {
    String biggerText;
    String smallerText;
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
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                if (widget.prefix != null) widget.prefix,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BiggerText(text: widget.biggerText),
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

/// Чекбокс определяющий повторять ли привычку в течение дня
class HabitRepeatDuringDayCheckbox extends StatefulWidget {
  /// Начальное значение выбора чекбокса
  final bool initial;

  /// Событие смены выбора чекбокса
  final Function(bool selected) change;

  /// Создает чекбокс
  const HabitRepeatDuringDayCheckbox({Key key, this.initial, this.change})
      : super(key: key);

  @override
  _HabitRepeatDuringDayCheckboxState createState() =>
      _HabitRepeatDuringDayCheckboxState();
}

class _HabitRepeatDuringDayCheckboxState
    extends State<HabitRepeatDuringDayCheckbox> {
  bool selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Selectable(
      biggerText: "Повторы в течение дня",
      smallerText: "Например, 10 мин. 2 раза в день",
      prefix: Checkbox(
        onChanged: setSelected,
        value: selected,
        activeColor: CustomColors.yellow,
        checkColor: CustomColors.almostBlack,
      ),
      initial: selected,
      onSelected: setSelected,
      selectedColor: Colors.white,
      unselectedColor: Colors.white,
    );
  }

  // ignore: avoid_positional_boolean_parameters
  void setSelected(bool selected) {
    setState(() => this.selected = selected);
    widget.change(this.selected);
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
