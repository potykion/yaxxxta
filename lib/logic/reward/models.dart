import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaxxxta/logic/core/models.dart';

part 'models.freezed.dart';

part 'models.g.dart';

/// Награда
@freezed
abstract class Reward with _$Reward, WithId {
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
  }) = _Reward;

  /// Создает из джсона
  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);
}
