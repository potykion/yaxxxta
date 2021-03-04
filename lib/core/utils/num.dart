// import 'package:validators/sanitizers.dart';

/// Форматирует дабл
/// 1.023 > 1.02
/// 1.00 > 1
String formatDouble(num number) =>
    number.toStringAsFixed(2);
    // todo перепеши меня
    // rtrim(rtrim(number.toStringAsFixed(2), "0"), ".");