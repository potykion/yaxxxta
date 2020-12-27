import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

extension DurationUtils on Duration {
  /// Форматирует дюрейшн без нулей впереди и без миллисекунд, типа 1:02:03
  String format() => [
        this.inHours > 0 ? this.inHours : null,
        this.inMinutes > 0 ? this.inMinutes % 60 : null,
        this.inSeconds % 60
      ]
          .where((d) => d != null)
          .toList()
          .asMap()
          .entries
          .map((e) => e.key == 0 ? e.value : e.value.toString().padLeft(2, "0"))
          .join(":");
}

/// Форматирует время (20:43)
String formatTime(DateTime time) => DateFormat.Hm().format(time);

/// Время начала дня по умолчанию
final defaultDayEnd = DateTime(2020, 1, 1, 23, 59);

/// Время конца дня по умолчанию
final defaultDayStart = DateTime(2020, 1, 1, 0, 0);

/// Собирает дейттайм из даты и времени
DateTime buildDateTime(DateTime date, DateTime time) => DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

/// Определяет день, когда месяц заканчивается
int endOfMonth(DateTime date) => DateTime(date.year, date.month + 1, 0).day;

/// Определяет номер дня в рамках года
int yearDayNum(DateTime date) =>
    date.difference(DateTime(date.year, 1, 1)).inDays + 1;

/// Определяет номер недели в рамках года
int yearWeekNum(DateTime date) {
  var yearStartWeek = DateTime(date.year, 1, 1)
      .subtract(Duration(days: DateTime(date.year, 1, 1).day));

  return date.difference(yearStartWeek).inDays ~/ 7 + 1;
}

extension DateTimeUtils on DateTime {
  DateTime date() => DateTime(this.year, this.month, this.day);

  DateTime time({bool withSeconds = false}) => DateTime(
        2020,
        1,
        1,
        this.hour,
        this.minute,
        withSeconds ? this.second : 0,
      );

}


