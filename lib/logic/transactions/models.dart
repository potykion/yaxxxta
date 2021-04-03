import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';

part 'models.g.dart';

/// Транзакция - запись о том, что было начислено/списано сколько-то баллов юзеру
@freezed
abstract class Transaction with _$Transaction {
  /// Транзакция
  const factory Transaction({
    String? id,
    required DateTime createed,
    required int performingPoints,
    required String userId,
  }) = _Transaction;

  /// Создает из джсон
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
