import 'string.dart';

/// Форматирует дабл
/// 1.023 > 1.02
/// 1.00 > 1
String formatDouble(num number) =>
    rtrim(rtrim(number.toStringAsFixed(2), "0"), ".");

/// Расширения для инта
extension IntExtensions on int {
  /// Создает ренж, длиной = числу
  List<int> range() => List.generate(this, (index) => index);
}
