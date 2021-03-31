import 'package:yaxxxta/logic/core/utils/num.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:intl/intl.dart';
import 'package:yaxxxta/widgets/core/fit_icon_button.dart';
import 'package:yaxxxta/widgets/core/padding.dart';
import '../../logic/core/utils/dt.dart';
import '../../theme.dart';
import 'text.dart';
import 'swiper.dart';

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
    /// Сдвигаем лист-вью на половину экрана + 30 - половина DateCarouselCell,
    /// чтобы текущий день был посерединке
    var isc = useState(IndexedScrollController(
      initialScrollOffset: -MediaQuery.of(context).size.width / 2 + 30,
    ));

    /// При смене [initial] даты сдвигаем дополнительно
    /// на 60 * разницу между текущим днем и [initial]
    useValueChanged<DateTime, void>(
      initial,
      (_, __) {
        isc.value.jumpTo(-MediaQuery.of(context).size.width / 2 +
            30 -
            60 * (DateTime.now().date().difference(initial)).inDays);
      },
    );

    return SizedBox(
      height: 75,
      child: IndexedListView.builder(
        controller: isc.value,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          var shiftDate = DateTime.now().date().add(Duration(days: index));

          return GestureDetector(
            onTap: () => change(shiftDate),
            child: DateCell(
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
class DateCell extends StatelessWidget {
  /// Дата
  final DateTime date;

  /// Цвет
  final Color? color;

  /// Показывать день недели
  final bool withWeekday;

  /// Показывать месяц
  final bool withMonth;

  /// Если true, то делает текст серым
  final bool disabled;

  /// Создает ячейку
  const DateCell({
    Key? key,
    required this.date,
    this.color,
    this.withWeekday = true,
    this.withMonth = true,
    this.disabled = false,
  }) : super(key: key);

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
              color: color ?? Colors.white,
            ),
            width: 42,
            height: 42,
            child: Center(
              child: Text(
                (withMonth ? DateFormat("dd.\nMM") : DateFormat("dd"))
                    .format(date),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: disabled ? CustomColors.grey : null,
                ),
              ),
            ),
          ),
          if (withWeekday)
            SmallestText(
              "${DateFormat("E").format(date)}"
              "${date.isToday() ? " (седня)" : ""}",
            )
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

/// Календарик
class Calendar extends HookWidget {
  /// Начальная дата
  final DateTime initial;

  /// Событие изменения даты
  final Function(DateTime date) change;

  /// Подсветска выбора даты - мапа, где ключ - дата, значение - интенсивность
  /// (напр. ячейка даты зеленая - в этот день привычка была выполнена)
  final Map<DateTime, double> highlights;

  /// Календарик
  const Calendar({
    Key? key,
    required this.initial,
    required this.change,
    required this.highlights,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedMonth = useState(initial);

    addMonth([int months = 1]) {
      selectedMonth.value = DateTime(
        selectedMonth.value.year,
        selectedMonth.value.month + months,
        1,
      );
    }

    var startDay = DateRange.withinWeek(
      DateTime(selectedMonth.value.year, selectedMonth.value.month, 1),
    ).from;

    return SizedBox(
      height: 290,
      child: Column(
        children: [
          SmallPadding.noBottom(
            child: Row(
              children: [
                FitIconButton(
                  icon: Icon(Icons.chevron_left),
                  onTap: () => addMonth(-1),
                ),
                Spacer(),
                Text(
                  DateFormat("MM.yyyy").format(selectedMonth.value),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                FitIconButton(
                  icon: Icon(Icons.chevron_right),
                  onTap: addMonth,
                ),
              ],
            ),
          ),
          Expanded(
            child: Swiper(
              builder: (context) => Column(
                children: [
                  for (var week in 6.range())
                    Row(
                      children: [
                        for (var weekday in 7.range())
                          _buildDateCell(
                            selectedMonth.value,
                            startDay,
                            week,
                            weekday,
                          )
                      ],
                    )
                ],
              ),
              onSwipe: (isSwipeLeft) => addMonth(isSwipeLeft ? 1 : -1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateCell(
    DateTime selectedMonth,
    DateTime startDay,
    int week,
    int weekday,
  ) {
    var date = startDay.add(Duration(days: weekday + week * 7));

    return GestureDetector(
      onTap: () => change(date),
      child: DateCell(
        date: date,
        color: date == initial
            ? CustomColors.yellow
            : (highlights[date] ?? 0) > 0
                ? CustomColors.green
                : null,
        withWeekday: false,
        withMonth: false,
        disabled: date != initial && selectedMonth.month != date.month,
      ),
    );
  }
}
