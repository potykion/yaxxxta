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


String formatTime(DateTime time) => DateFormat.Hm().format(time);