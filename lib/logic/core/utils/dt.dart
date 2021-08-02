import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/models.dart';

part 'dt.freezed.dart';

/// Раширения дейттайма
extension DateTimeUtils on DateTime {
  /// Убирает время у дейттайма, то есть просто дата
  DateTime get date => DateTime(year, month, day);

  /// Чекает является ли дейттайм сегодняшним
  bool isToday() {
    var now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Соединяет дату и время
  DateTime combine(DateTime date, DateTime time) => DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
        time.second,
      );

  /// Двигает дейттайм на след день, относительно текущей даты
  DateTime setTomorrow() =>
      combine(DateTime.now().add(Duration(days: 1)), this);

  /// Недельный дейтренж
  DateRange get weekDateRange => DateRange(
        add(Duration(days: 1 - weekday)).date,
        add(Duration(days: 7 - weekday)).date,
      );

  /// Начало месяца
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Конец месяца
  DateTime get endOfMonth => DateTime(year, month + 1, 0);
}

/// Дейтренж - промежуток между 2 датами
@freezed
abstract class DateRange implements _$DateRange {
  const DateRange._();

  /// Дейтренж - промежуток между 2 датами
  const factory DateRange(
    DateTime from,
    DateTime to,
  ) = _DateRange;

  /// Даты, которые входят в дейтренж
  List<DateTime> get dates {
    return [
      for (var day
          in List.generate(to.difference(from).inDays + 1, (index) => index))
        from.add(Duration(days: day))
    ];
  }

  /// Если дейтренж содержит первое число месяца, то возвращает его
  DateTime? get firstMonthDay {
    final monthStarts = dates.where((d) => d == d.startOfMonth);
    if (monthStarts.isNotEmpty) return monthStarts.first;
    return null;
  }

  /// Дейтренж предыдущей недели
  DateRange get previousWeek {
    return DateRange(
      from.subtract(Duration(days: 7)),
      to.subtract(Duration(days: 7)),
    );
  }

  /// Включена ли дата в промежуток
  bool includes(DateTime date) => dates.contains(date);
}

/// TimeOfDay расширения
extension TimeExtenstions on TimeOfDay {
  /// Конвертит в дейттайм
  ///
  /// Полученный дейттайм всегда позже текущего времени
  /// Например. сейчас 2021-08-01 08:40, а тайм-ой-дей = 08:00 =>
  /// Функция вернет 2021-08-02 08:00
  ///
  /// Если указан день недели, то считается дейттайм с указанным днем
  /// Например. сейчас 2021-08-01 (вс) 08:40, тайм-ой-дей = 08:00,
  /// день недели - пн =>
  /// Функция вернет 2021-08-02 (пн) 08:00
  DateTime toDateTime({DateTime? now, Weekday? weekday}) {
    now = now ?? DateTime.now();

    var dt = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (dt.isBefore(now)) {
      dt = dt.add(Duration(days: 1));
    }

    if (weekday != null) {
      while (true) {
        if (dt.weekday == weekday.index + 1) {
          break;
        }
        dt = dt.add(Duration(days: 1));
      }
    }

    return dt;
  }
}
