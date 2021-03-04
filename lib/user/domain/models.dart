import 'package:freezed_annotation/freezed_annotation.dart';
import '../../settings/domain/models.dart';

part 'models.freezed.dart';

part 'models.g.dart';

@freezed
abstract class UserData implements _$UserData {
  const UserData._();

  factory UserData({
    String? userId,
    required List<String> deviceIds,
    required List<String> habitIds,
    required Settings settings,
  }) = _UserData;

  factory UserData.fromJson(Map json) =>
      _$UserDataFromJson(Map<String, dynamic>.from(json));

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
