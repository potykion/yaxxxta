import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_listview/infinite_listview.dart';

import '../../../theme.dart';
import '../../utils/dt.dart';
import 'text.dart';

/// Выбор даты
class DatePicker extends HookWidget {
  /// Начальная дата
  final DateTime initial;

  /// Событие изменения даты
  final Function(DateTime date) change;

  /// Подсветска выбора даты - мапа, где ключ - дата, значение - интенсивность
  /// (напр. ячейка даты зеленая - в этот день привычка была выполнена)
  final Map<DateTime, double> highlights;

  /// Выбор даты
  DatePicker({
    Map<DateTime, double> highlights,
    DateTime initial,
    @required this.change,
  })  : initial = initial ?? DateTime.now().date(),
        highlights = highlights ?? {};

  @override
  Widget build(BuildContext context) {
    var selectedIndexState = useState(0);

    return SizedBox(
      height: 70,
      child: InfiniteListView.builder(
        /// Сдвигаем лист-вью на половину экрана + 3 паддинга по 10,
        /// чтобы текущий день был посерединке
        controller: InfiniteScrollController(
          initialScrollOffset: -MediaQuery.of(context).size.width / 2 + 3 * 10,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          var shiftDate = initial.add(Duration(days: index));

          return GestureDetector(
            onTap: () {
              selectedIndexState.value = index;
              change(shiftDate);
            },
            child: DatePickerItem(
              date: shiftDate,
              color: selectedIndexState.value == index
                  ? CustomColors.yellow
                  : CustomColors.green.withAlpha(
                      highlights.containsKey(shiftDate)
                          ? (255 * highlights[shiftDate]).toInt()
                          : 0,
                    ),
            ),
          );
        },
      ),
    );
  }
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
