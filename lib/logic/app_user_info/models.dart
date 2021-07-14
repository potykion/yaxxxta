import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:yaxxxta/logic/core/models.dart';

part 'models.freezed.dart';

part 'models.g.dart';

/// Инфа о юзере
@freezed
abstract class AppUserInfo implements _$AppUserInfo, WithId {
  const AppUserInfo._();

  /// Инфа о юзере
  factory AppUserInfo({
    String? id,
    required String userId,
    DateTime? subscriptionExpiration,
  }) = _AppUserInfo;

  /// Грузит из джсона
  factory AppUserInfo.fromJson(Map<String, dynamic> json) =>
      _$AppUserInfoFromJson(json);

  /// Есть ли подписка
  bool get haveSubscription =>
      subscriptionExpiration?.isAfter(DateTime.now()) ?? false;

  /// Дата окончания подписки
  String get subscriptionExpirationStr => subscriptionExpiration != null
      ? DateFormat.yMd().format(subscriptionExpiration!)
      : "";
}
