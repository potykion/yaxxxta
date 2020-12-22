import 'package:intl/intl.dart';

/// Форматирует дюрейшн без нулей впереди и без миллисекунд, типа 1:02:03
String formatDuration(Duration duration) => [
      duration.inHours > 0 ? duration.inHours : null,
      duration.inMinutes > 0 ? duration.inMinutes % 60 : null,
      duration.inSeconds % 60
    ]
        .where((d) => d != null)
        .toList()
        .asMap()
        .entries
        .map((e) => e.key == 0 ? e.value : e.value.toString().padLeft(2, "0"))
        .join(":");

/// Форматирует время (20:43)
String formatTime(DateTime time) => DateFormat.Hm().format(time);

/// Время начала дня по умолчанию
final defaultDayEnd = DateTime(2020, 1, 1, 23, 59);

/// Время конца дня по умолчанию
final defaultDayStart = DateTime(2020, 1, 1);

/// Собирает дейттайм из даты и времени
DateTime buildDateTime(DateTime date, DateTime time) {
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}

/// Определяет день, когда месяц заканчивается
int endOfMonth(DateTime date) => DateTime(date.year, date.month + 1, 0).day;
