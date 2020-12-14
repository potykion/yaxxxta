import 'package:intl/intl.dart';
import 'package:validators/sanitizers.dart';

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

/// Форматирует дабл
/// 1.023 > 1.02
/// 1.00 > 1
String formatDouble(num number) =>
    rtrim(rtrim(number.toStringAsFixed(2), "0"), ".");

final DefaultDayStart = DateTime(2020, 1, 1);
final DefaultDayEnd = DateTime(2020, 1, 1, 23, 59);
