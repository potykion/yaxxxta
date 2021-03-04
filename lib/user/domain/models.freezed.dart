// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return _UserData.fromJson(json);
}

/// @nodoc
class _$UserDataTearOff {
  const _$UserDataTearOff();

  _UserData call(
      {String? userId,
      required List<String> deviceIds,
      required List<String> habitIds,
      required Settings settings}) {
    return _UserData(
      userId: userId,
      deviceIds: deviceIds,
      habitIds: habitIds,
      settings: settings,
    );
  }

  UserData fromJson(Map<String, Object> json) {
    return UserData.fromJson(json);
  }
}

/// @nodoc
const $UserData = _$UserDataTearOff();

/// @nodoc
mixin _$UserData {
  String? get userId => throw _privateConstructorUsedError;
  List<String> get deviceIds => throw _privateConstructorUsedError;
  List<String> get habitIds => throw _privateConstructorUsedError;
  Settings get settings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataCopyWith<UserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) then) =
      _$UserDataCopyWithImpl<$Res>;
  $Res call(
      {String? userId,
      List<String> deviceIds,
      List<String> habitIds,
      Settings settings});

  $SettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res> implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._value, this._then);

  final UserData _value;
  // ignore: unused_field
  final $Res Function(UserData) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? deviceIds = freezed,
    Object? habitIds = freezed,
    Object? settings = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed ? _value.userId : userId as String?,
      deviceIds:
          deviceIds == freezed ? _value.deviceIds : deviceIds as List<String>,
      habitIds:
          habitIds == freezed ? _value.habitIds : habitIds as List<String>,
      settings: settings == freezed ? _value.settings : settings as Settings,
    ));
  }

  @override
  $SettingsCopyWith<$Res> get settings {
    return $SettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value));
    });
  }
}

/// @nodoc
abstract class _$UserDataCopyWith<$Res> implements $UserDataCopyWith<$Res> {
  factory _$UserDataCopyWith(_UserData value, $Res Function(_UserData) then) =
      __$UserDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? userId,
      List<String> deviceIds,
      List<String> habitIds,
      Settings settings});

  @override
  $SettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$UserDataCopyWithImpl<$Res> extends _$UserDataCopyWithImpl<$Res>
    implements _$UserDataCopyWith<$Res> {
  __$UserDataCopyWithImpl(_UserData _value, $Res Function(_UserData) _then)
      : super(_value, (v) => _then(v as _UserData));

  @override
  _UserData get _value => super._value as _UserData;

  @override
  $Res call({
    Object? userId = freezed,
    Object? deviceIds = freezed,
    Object? habitIds = freezed,
    Object? settings = freezed,
  }) {
    return _then(_UserData(
      userId: userId == freezed ? _value.userId : userId as String?,
      deviceIds:
          deviceIds == freezed ? _value.deviceIds : deviceIds as List<String>,
      habitIds:
          habitIds == freezed ? _value.habitIds : habitIds as List<String>,
      settings: settings == freezed ? _value.settings : settings as Settings,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_UserData extends _UserData {
  _$_UserData(
      {this.userId,
      required this.deviceIds,
      required this.habitIds,
      required this.settings})
      : super._();

  factory _$_UserData.fromJson(Map<String, dynamic> json) =>
      _$_$_UserDataFromJson(json);

  @override
  final String? userId;
  @override
  final List<String> deviceIds;
  @override
  final List<String> habitIds;
  @override
  final Settings settings;

  @override
  String toString() {
    return 'UserData(userId: $userId, deviceIds: $deviceIds, habitIds: $habitIds, settings: $settings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserData &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.deviceIds, deviceIds) ||
                const DeepCollectionEquality()
                    .equals(other.deviceIds, deviceIds)) &&
            (identical(other.habitIds, habitIds) ||
                const DeepCollectionEquality()
                    .equals(other.habitIds, habitIds)) &&
            (identical(other.settings, settings) ||
                const DeepCollectionEquality()
                    .equals(other.settings, settings)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(deviceIds) ^
      const DeepCollectionEquality().hash(habitIds) ^
      const DeepCollectionEquality().hash(settings);

  @JsonKey(ignore: true)
  @override
  _$UserDataCopyWith<_UserData> get copyWith =>
      __$UserDataCopyWithImpl<_UserData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserDataToJson(this);
  }
}

abstract class _UserData extends UserData {
  _UserData._() : super._();
  factory _UserData(
      {String? userId,
      required List<String> deviceIds,
      required List<String> habitIds,
      required Settings settings}) = _$_UserData;

  factory _UserData.fromJson(Map<String, dynamic> json) = _$_UserData.fromJson;

  @override
  String? get userId => throw _privateConstructorUsedError;
  @override
  List<String> get deviceIds => throw _privateConstructorUsedError;
  @override
  List<String> get habitIds => throw _privateConstructorUsedError;
  @override
  Settings get settings => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserDataCopyWith<_UserData> get copyWith =>
      throw _privateConstructorUsedError;
}
