import 'package:validators/sanitizers.dart';

/// Форматирует дабл
/// 1.023 > 1.02
/// 1.00 > 1
String formatDouble(num number) =>
    rtrim(rtrim(number.toStringAsFixed(2), "0"), ".");