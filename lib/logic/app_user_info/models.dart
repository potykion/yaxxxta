import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:yaxxxta/logic/core/models.dart';

part 'models.freezed.dart';

part 'models.g.dart';

@freezed
abstract class AppUserInfo implements _$AppUserInfo, WithId {
  const AppUserInfo._();

  factory AppUserInfo({
    String? id,
    required String userId,
    DateTime? subscriptionExpiration,
  }) = _AppUserInfo;

  factory AppUserInfo.fromJson(Map<String, dynamic> json) =>
      _$AppUserInfoFromJson(json);

  bool get haveSubscription =>
      subscriptionExpiration?.isAfter(DateTime.now()) ?? false;

  String get subscriptionExpirationStr => subscriptionExpiration != null
      ? DateFormat.yMd().format(subscriptionExpiration!)
      : "";
}
