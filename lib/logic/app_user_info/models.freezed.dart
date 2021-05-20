// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppUserInfo _$AppUserInfoFromJson(Map<String, dynamic> json) {
  return _AppUserInfo.fromJson(json);
}

/// @nodoc
class _$AppUserInfoTearOff {
  const _$AppUserInfoTearOff();

  _AppUserInfo call(
      {String? id, required String userId, bool haveSubscription = false}) {
    return _AppUserInfo(
      id: id,
      userId: userId,
      haveSubscription: haveSubscription,
    );
  }

  AppUserInfo fromJson(Map<String, Object> json) {
    return AppUserInfo.fromJson(json);
  }
}

/// @nodoc
const $AppUserInfo = _$AppUserInfoTearOff();

/// @nodoc
mixin _$AppUserInfo {
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  bool get haveSubscription => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserInfoCopyWith<AppUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserInfoCopyWith<$Res> {
  factory $AppUserInfoCopyWith(
          AppUserInfo value, $Res Function(AppUserInfo) then) =
      _$AppUserInfoCopyWithImpl<$Res>;
  $Res call({String? id, String userId, bool haveSubscription});
}

/// @nodoc
class _$AppUserInfoCopyWithImpl<$Res> implements $AppUserInfoCopyWith<$Res> {
  _$AppUserInfoCopyWithImpl(this._value, this._then);

  final AppUserInfo _value;
  // ignore: unused_field
  final $Res Function(AppUserInfo) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? haveSubscription = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      haveSubscription: haveSubscription == freezed
          ? _value.haveSubscription
          : haveSubscription // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$AppUserInfoCopyWith<$Res>
    implements $AppUserInfoCopyWith<$Res> {
  factory _$AppUserInfoCopyWith(
          _AppUserInfo value, $Res Function(_AppUserInfo) then) =
      __$AppUserInfoCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String userId, bool haveSubscription});
}

/// @nodoc
class __$AppUserInfoCopyWithImpl<$Res> extends _$AppUserInfoCopyWithImpl<$Res>
    implements _$AppUserInfoCopyWith<$Res> {
  __$AppUserInfoCopyWithImpl(
      _AppUserInfo _value, $Res Function(_AppUserInfo) _then)
      : super(_value, (v) => _then(v as _AppUserInfo));

  @override
  _AppUserInfo get _value => super._value as _AppUserInfo;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? haveSubscription = freezed,
  }) {
    return _then(_AppUserInfo(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      haveSubscription: haveSubscription == freezed
          ? _value.haveSubscription
          : haveSubscription // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppUserInfo extends _AppUserInfo {
  _$_AppUserInfo({this.id, required this.userId, this.haveSubscription = false})
      : super._();

  factory _$_AppUserInfo.fromJson(Map<String, dynamic> json) =>
      _$_$_AppUserInfoFromJson(json);

  @override
  final String? id;
  @override
  final String userId;
  @JsonKey(defaultValue: false)
  @override
  final bool haveSubscription;

  @override
  String toString() {
    return 'AppUserInfo(id: $id, userId: $userId, haveSubscription: $haveSubscription)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AppUserInfo &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.haveSubscription, haveSubscription) ||
                const DeepCollectionEquality()
                    .equals(other.haveSubscription, haveSubscription)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(haveSubscription);

  @JsonKey(ignore: true)
  @override
  _$AppUserInfoCopyWith<_AppUserInfo> get copyWith =>
      __$AppUserInfoCopyWithImpl<_AppUserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AppUserInfoToJson(this);
  }
}

abstract class _AppUserInfo extends AppUserInfo {
  factory _AppUserInfo(
      {String? id,
      required String userId,
      bool haveSubscription}) = _$_AppUserInfo;
  _AppUserInfo._() : super._();

  factory _AppUserInfo.fromJson(Map<String, dynamic> json) =
      _$_AppUserInfo.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String get userId => throw _privateConstructorUsedError;
  @override
  bool get haveSubscription => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AppUserInfoCopyWith<_AppUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
