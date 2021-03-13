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
      {String? id,
      String? userId,
      List<String> deviceIds = const <String>[],
      List<String> habitIds = const <String>[],
      required Settings settings,
      int performingPoints = 0,
      List<String> rewardIds = const <String>[]}) {
    return _UserData(
      id: id,
      userId: userId,
      deviceIds: deviceIds,
      habitIds: habitIds,
      settings: settings,
      performingPoints: performingPoints,
      rewardIds: rewardIds,
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
  /// Айди
  String? get id => throw _privateConstructorUsedError;

  /// Айди юзера
  String? get userId => throw _privateConstructorUsedError;

  /// Айди девайсов
  List<String> get deviceIds => throw _privateConstructorUsedError;

  /// Айди привычек
  List<String> get habitIds => throw _privateConstructorUsedError;

  /// Настройки
  Settings get settings => throw _privateConstructorUsedError;

  /// Баллы, которые можно потратить на вознаграждение
  int get performingPoints => throw _privateConstructorUsedError;

  /// Айди наград
  List<String> get rewardIds => throw _privateConstructorUsedError;

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
      {String? id,
      String? userId,
      List<String> deviceIds,
      List<String> habitIds,
      Settings settings,
      int performingPoints,
      List<String> rewardIds});

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
    Object? id = freezed,
    Object? userId = freezed,
    Object? deviceIds = freezed,
    Object? habitIds = freezed,
    Object? settings = freezed,
    Object? performingPoints = freezed,
    Object? rewardIds = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String?,
      userId: userId == freezed ? _value.userId : userId as String?,
      deviceIds:
          deviceIds == freezed ? _value.deviceIds : deviceIds as List<String>,
      habitIds:
          habitIds == freezed ? _value.habitIds : habitIds as List<String>,
      settings: settings == freezed ? _value.settings : settings as Settings,
      performingPoints: performingPoints == freezed
          ? _value.performingPoints
          : performingPoints as int,
      rewardIds:
          rewardIds == freezed ? _value.rewardIds : rewardIds as List<String>,
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
      {String? id,
      String? userId,
      List<String> deviceIds,
      List<String> habitIds,
      Settings settings,
      int performingPoints,
      List<String> rewardIds});

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
    Object? id = freezed,
    Object? userId = freezed,
    Object? deviceIds = freezed,
    Object? habitIds = freezed,
    Object? settings = freezed,
    Object? performingPoints = freezed,
    Object? rewardIds = freezed,
  }) {
    return _then(_UserData(
      id: id == freezed ? _value.id : id as String?,
      userId: userId == freezed ? _value.userId : userId as String?,
      deviceIds:
          deviceIds == freezed ? _value.deviceIds : deviceIds as List<String>,
      habitIds:
          habitIds == freezed ? _value.habitIds : habitIds as List<String>,
      settings: settings == freezed ? _value.settings : settings as Settings,
      performingPoints: performingPoints == freezed
          ? _value.performingPoints
          : performingPoints as int,
      rewardIds:
          rewardIds == freezed ? _value.rewardIds : rewardIds as List<String>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_UserData extends _UserData {
  _$_UserData(
      {this.id,
      this.userId,
      this.deviceIds = const <String>[],
      this.habitIds = const <String>[],
      required this.settings,
      this.performingPoints = 0,
      this.rewardIds = const <String>[]})
      : super._();

  factory _$_UserData.fromJson(Map<String, dynamic> json) =>
      _$_$_UserDataFromJson(json);

  @override

  /// Айди
  final String? id;
  @override

  /// Айди юзера
  final String? userId;
  @JsonKey(defaultValue: const <String>[])
  @override

  /// Айди девайсов
  final List<String> deviceIds;
  @JsonKey(defaultValue: const <String>[])
  @override

  /// Айди привычек
  final List<String> habitIds;
  @override

  /// Настройки
  final Settings settings;
  @JsonKey(defaultValue: 0)
  @override

  /// Баллы, которые можно потратить на вознаграждение
  final int performingPoints;
  @JsonKey(defaultValue: const <String>[])
  @override

  /// Айди наград
  final List<String> rewardIds;

  @override
  String toString() {
    return 'UserData(id: $id, userId: $userId, deviceIds: $deviceIds, habitIds: $habitIds, settings: $settings, performingPoints: $performingPoints, rewardIds: $rewardIds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserData &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
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
                    .equals(other.settings, settings)) &&
            (identical(other.performingPoints, performingPoints) ||
                const DeepCollectionEquality()
                    .equals(other.performingPoints, performingPoints)) &&
            (identical(other.rewardIds, rewardIds) ||
                const DeepCollectionEquality()
                    .equals(other.rewardIds, rewardIds)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(deviceIds) ^
      const DeepCollectionEquality().hash(habitIds) ^
      const DeepCollectionEquality().hash(settings) ^
      const DeepCollectionEquality().hash(performingPoints) ^
      const DeepCollectionEquality().hash(rewardIds);

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
      {String? id,
      String? userId,
      List<String> deviceIds,
      List<String> habitIds,
      required Settings settings,
      int performingPoints,
      List<String> rewardIds}) = _$_UserData;

  factory _UserData.fromJson(Map<String, dynamic> json) = _$_UserData.fromJson;

  @override

  /// Айди
  String? get id => throw _privateConstructorUsedError;
  @override

  /// Айди юзера
  String? get userId => throw _privateConstructorUsedError;
  @override

  /// Айди девайсов
  List<String> get deviceIds => throw _privateConstructorUsedError;
  @override

  /// Айди привычек
  List<String> get habitIds => throw _privateConstructorUsedError;
  @override

  /// Настройки
  Settings get settings => throw _privateConstructorUsedError;
  @override

  /// Баллы, которые можно потратить на вознаграждение
  int get performingPoints => throw _privateConstructorUsedError;
  @override

  /// Айди наград
  List<String> get rewardIds => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserDataCopyWith<_UserData> get copyWith =>
      throw _privateConstructorUsedError;
}
