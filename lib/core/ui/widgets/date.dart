import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_listview/infinite_listview.dart';

import '../../../theme.dart';

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
