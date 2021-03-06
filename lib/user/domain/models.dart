import 'package:freezed_annotation/freezed_annotation.dart';
import '../../settings/domain/models.dart';

part 'models.freezed.dart';

part 'models.g.dart';

/// Данные о юзере
@freezed
abstract class UserData implements _$UserData {
  const UserData._();

  /// Данные о юзере
  factory UserData({
    /// Айди
    String? id,

    /// Айди юзера
    String? userId,

    /// Айди девайсов
    required List<String> deviceIds,

    /// Айди привычек
    required List<String> habitIds,

    /// Настройки
    required Settings settings,
  }) = _UserData;

  /// Создает из юзера
  factory UserData.fromJson(Map json) =>
      _$UserDataFromJson(Map<String, dynamic>.from(json));

  /// Создает пустышку
  factory UserData.blank({
    required String deviceId,
    String? userId,
  }) {
    return UserData(
      userId: userId,
      deviceIds: [deviceId],
      habitIds: [],
      settings: Settings.createDefault(),
    );
  }
}
