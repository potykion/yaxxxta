import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaxxxta/logic/core/models.dart';

part 'models.freezed.dart';

part 'models.g.dart';

/// Транзакция - запись о том, что было начислено/списано сколько-то баллов юзеру
@freezed
class PerformingPointTransaction
    with _$PerformingPointTransaction
    implements WithExternalId {
  const factory PerformingPointTransaction.habitIncome({
    String? id,
    String? externalId,
    required DateTime created,
    @Default(1) int performingPoints,
    String? userId,
    required String habitId,
  }) = HabitTransaction;

  const factory PerformingPointTransaction.rewardLoss({
    String? id,
    String? externalId,
    required DateTime created,
    required int performingPoints,
    String? userId,
    required String rewardId,
  }) = RewardTransaction;

  /// Создает из джсон
  factory PerformingPointTransaction.fromJson(Map<String, dynamic> json) =>
      _$PerformingPointTransactionFromJson(json);
}
