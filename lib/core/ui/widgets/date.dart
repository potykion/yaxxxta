import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_listview/infinite_listview.dart';

import '../../../theme.dart';

/// Выбор даты
class DatePicker extends HookWidget {
  /// Событие изменения даты
  final Function(DateTime date) change;

  /// @nodoc
  DatePicker({@required this.change});

  @override
  Widget build(BuildContext context) {
    var selectedIndexState = useState(0);

    return SizedBox(
      height: 60,
      child: InfiniteListView.builder(
        /// Сдвигаем лист-вью на половину экрана + 3 паддинга по 10,
        /// чтобы текущий день был посерединке
        controller: InfiniteScrollController(
          initialScrollOffset: -MediaQuery.of(context).size.width / 2 + 3 * 10,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => GestureDetector(
          onTap: () {
            selectedIndexState.value = index;
            change(DateTime.now().add(Duration(days: index)));
          },
          child: DatePickerItem(
            date: DateTime.now().add(Duration(days: index)),
            color: selectedIndexState.value == index
                ? CustomColors.yellow
                : Colors.transparent,
          ),
        ),
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
