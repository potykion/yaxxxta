import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaxxxta/logic/core/models.dart';

part 'models.freezed.dart';

part 'models.g.dart';

/// Награда
@freezed
abstract class Reward implements _$Reward, WithExternalId {
  const Reward._();

  /// Награда
  const factory Reward({
    /// Айди
    String? id,

    /// Название
    required String title,

    /// Стоимость
    /// Сколько баллов (performingPoints) нужно потратить,
    /// чтобы получить награду
    required int cost,

    /// Награда получена?
    @Default(false) bool collected,

    /// Айди сторонней системы, напр. айди из Firebase
    String? externalId,
  }) = _Reward;

  /// Создает из джсона
  factory Reward.fromJson(Map json) =>
      _$RewardFromJson(Map<String, dynamic>.from(json));

  /// Может ли награда быть получена?
  bool canBeCollected(int userPerformingPoints) {
    return cost <= userPerformingPoints;
  }
}
