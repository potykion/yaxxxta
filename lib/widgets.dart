import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:yaxxxta/utils.dart';
import 'package:yaxxxta/view_models.dart';

import 'theme.dart';

class HabitCard extends StatefulWidget {
  final HabitVM vm;
  final int repeatIndex;

  const HabitCard({
    Key key,
    this.vm,
    this.repeatIndex,
  }) : super(key: key);

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  get title => widget.vm.title;

  HabitRepeat get repeat => widget.vm.repeats[widget.repeatIndex];

  get isSingleRepeat => widget.vm.repeats.length == 1;

  get repeatCounter =>
      "${widget.repeatIndex + 1} / ${widget.vm.repeats.length}";

  @override
  Widget build(BuildContext context) => PaddedContainerCard(children: [
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
          progressPercentage: repeat.progressPercentage,
          progressStr: repeat.progressStr,
          type: repeat.type,
          isSingleRepeat: repeat.isSingle,
        )
      ]);
}

class PaddedContainerCard extends StatelessWidget {
  final List<Widget> children;

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

class DatePickerItem extends StatelessWidget {
  final DateTime date;
  final Color color;

  const DatePickerItem({Key key, this.date, this.color = Colors.white})
      : super(key: key);

  get dateStr => "${date.day}.\n${date.month}";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: this.color,
        ),
        width: 50,
        child: Center(
          child: Text(
            dateStr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class DateScroll extends StatefulWidget {
  @override
  _DateScrollState createState() => _DateScrollState();
}

class _DateScrollState extends State<DateScroll> {
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

class HabitProgressControl extends StatelessWidget {
  final double progressPercentage;
  final String progressStr;
  final HabitType type;
  final bool isSingleRepeat;

  const HabitProgressControl(
      {Key key,
      this.progressPercentage,
      this.progressStr,
      this.type,
      this.isSingleRepeat})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Container(
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                value: progressPercentage,
                backgroundColor: Color(0xffFAFAFA),
                valueColor: AlwaysStoppedAnimation<Color>(CustomColors.green
                    .withAlpha((progressPercentage * 255).toInt())),
              ),
            ),
          ),
          Positioned(
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                splashRadius: 20,
                icon: type == HabitType.time
                    ? Icon(Icons.play_arrow)
                    : Icon(Icons.done),
                onPressed: () {
                  //  todo type == HabitType.time / repeats
                },
              ),
            ),
          ),
          if (!isSingleRepeat)
            Positioned(
              child: SmallerText(text: progressStr, dark: true),
              right: 20,
            )
        ],
      );
}

class SmallerText extends StatelessWidget {
  final String text;
  final bool dark;
  final bool light;

  const SmallerText({Key key, this.text, this.dark = false, this.light = false})
      : super(key: key);

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

class BiggerText extends StatelessWidget {
  final String text;

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

class BiggestText extends StatelessWidget {
  final String text;

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

class TextInput<T> extends StatefulWidget {
  final T initial;
  final void Function(dynamic value) change;
  final Widget suffix;

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
          if (formatDouble(widget.initial) != formatDouble(value)) {
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

  setTecValue() {
    if (isNumberInput) {
      tec.text = formatDouble(widget.initial);
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

class HabitTypeInput extends StatefulWidget {
  final HabitType initial;
  final Function(HabitType habitType) change;

  /// Если true, то прячит остальные типы привычек
  final bool setBefore;

  const HabitTypeInput({
    Key key,
    @required this.initial,
    @required this.change,
    this.setBefore = false,
  }) : super(key: key);

  @override
  _HabitTypeInputState createState() => _HabitTypeInputState();
}

class _HabitTypeInputState extends State<HabitTypeInput> {
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

  buildHabitTypeRadio(HabitType habitType) {
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

    var changeHabitType = () {
      setState(() => selectedHabitType = habitType);
      widget.change(selectedHabitType);
    };

    return Selectable(
      biggerText: biggerText,
      smallerText: smallerText,
      initial: selectedHabitType == habitType,
      onSelected: (_) => changeHabitType(),
      prefix: Radio(
        value: habitType,
        groupValue: selectedHabitType,
        onChanged: (_) => changeHabitType(),
        activeColor: CustomColors.almostBlack,
      ),
    );
  }
}

class Selectable extends StatefulWidget {
  final String biggerText;
  final String smallerText;
  final bool initial;
  final Function onSelected;
  final Widget prefix;
  final Color selectedColor;
  final Color unselectedColor;

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
        onTap: () => toggleSelected(),
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

  toggleSelected() {
    setState(() => selected = !selected);
    widget.onSelected(selected);
  }
}

class HabitRepeatDuringDayCheckbox extends StatefulWidget {
  final bool initial;
  final Function change;

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
        onChanged: (newSelected) => setSelected(newSelected),
        value: selected,
        activeColor: CustomColors.yellow,
        checkColor: CustomColors.almostBlack,
      ),
      initial: selected,
      onSelected: (newSelected) => setSelected(newSelected),
      selectedColor: Colors.white,
      unselectedColor: Colors.white,
    );
  }

  setSelected(bool selected) {
    setState(() => this.selected = selected);
    widget.change(this.selected);
  }
}

class SimpleButton extends StatelessWidget {
  final String text;
  final Function onTap;

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

class SimpleChip extends StatelessWidget {
  final String text;
  final bool selected;
  final Function(bool selected) change;
  final Color color;
  final EdgeInsetsGeometry padding;

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

class PeriodTypeSelect extends StatefulWidget {
  final HabitPeriodType initial;
  final Function(HabitPeriodType type) change;

  const PeriodTypeSelect(
      {Key key, @required this.initial, @required this.change})
      : super(key: key);

  @override
  _PeriodTypeSelectState createState() => _PeriodTypeSelectState();
}

class _PeriodTypeSelectState extends State<PeriodTypeSelect> {
  HabitPeriodType type;

  @override
  void initState() {
    super.initState();
    type = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
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
      items: [HabitPeriodType.day, HabitPeriodType.week, HabitPeriodType.month]
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
}

class WeekdaysPicker extends StatefulWidget {
  final List<Weekday> initial;
  final Function(List<Weekday> w) change;

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
    weekdays = widget.initial;
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
