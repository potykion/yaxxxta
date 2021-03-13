import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import '../../core/utils/dt.dart';
import '../../theme.dart';
import 'text.dart';

/// Барабан с датами
class DateCarousel extends HookWidget {
  /// Начальная дата
  final DateTime initial;

  /// Событие изменения даты
  final Function(DateTime date) change;

  /// Подсветска выбора даты - мапа, где ключ - дата, значение - интенсивность
  /// (напр. ячейка даты зеленая - в этот день привычка была выполнена)
  final Map<DateTime, double> highlights;

  /// Выбор даты
  DateCarousel({
    required this.initial,
    required this.change,
    Map<DateTime, double>? highlights,
  }) : highlights = highlights ?? {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: IndexedListView.builder(
        // /// Сдвигаем лист-вью на половину экрана + 3 паддинга по 10,
        // /// чтобы текущий день был посерединке
        controller: IndexedScrollController(
          initialScrollOffset: -MediaQuery.of(context).size.width / 2 + 3 * 10,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          var shiftDate = DateTime.now().date().add(Duration(days: index));

          return GestureDetector(
            onTap: () => change(shiftDate),
            child: DateCarouselCell(
              date: shiftDate,
              color: shiftDate == initial
                  ? CustomColors.yellow
                  : CustomColors.green.withAlpha(
                      highlights.containsKey(shiftDate)
                          ? (255 * highlights[shiftDate]!).toInt()
                          : 0,
                    ),
            ),
          );
        },
      ),
    );
  }
}

/// Ячейка барабана с датами
class DateCarouselCell extends StatelessWidget {
  /// Дата
  final DateTime date;

  /// Цвет
  final Color color;

  /// Создает ячейку
  const DateCarouselCell(
      {Key? key, required this.date, this.color = Colors.white})
      : super(key: key);

  String get _dateStr => "${date.day}.\n${date.month}";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
            ),
            width: 50,
            height: 50,
            child: Center(
                child: Text(
              _dateStr,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          ),
          SmallestText(date.isToday() ? "сегодня" : "")
        ],
      ),
    );
  }
}

/// Выбор даты
class DatePickerInput extends HookWidget {
  /// Начальное значение даты
  final DateTime? initial;

  /// Событие изменения даты
  final Function(DateTime time) change;

  /// Выбор даты
  DatePickerInput({this.initial, required this.change});

  @override
  Widget build(BuildContext context) {
    var tec = useTextEditingController(
      text: initial?.format() ?? "",
    );

    return TextFormField(
      controller: tec,
      readOnly: true,
      onTap: () async {
        var selected = (await showDatePicker(
              context: context,
              initialDate: initial ?? DateTime.now(),
              firstDate: DateTime.now().add(Duration(days: -365)),
              lastDate: DateTime.now().add(Duration(days: 365)),
            )) ??
            DateTime.now();
        tec.text = selected.format();
        change(selected);
      },
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.calendar_today,
          color: CustomColors.almostBlack,
        ),
      ),
    );
  }
}
