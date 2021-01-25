import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/db.dart';
import '../domain/models.dart';

/// Репо настроек на hive
class HiveSettingsRepo implements BaseSettingsRepo {
  final String _settingsKey = "settingsKey";
  final Box<Map> _habitBox;

  /// Репо настроек на hive
  HiveSettingsRepo(this._habitBox);

  @override
  Future<Settings> get() async {
    var settingsJson = _habitBox.get(_settingsKey);
    var settings = settingsJson != null
        ? Settings.fromJson(settingsJson)
        : Settings.createDefault();
    return settings;
  }

  @override
  Future<void> update(Settings settings) =>
      _habitBox.put(_settingsKey, settings.toJson());
}

/// Репо для настроек на шаред-префах
class SharedPreferencesSettingsRepo implements BaseSettingsRepo {
  final String _settingsKey = "settingsKey";
  final SharedPreferences _prefs;

  /// Репо для настроек на шаред-префах
  SharedPreferencesSettingsRepo(this._prefs);

  @override
  Future<Settings> get() async {
    var settingsJsonStr = _prefs.getString(_settingsKey);
    var settingsJson = settingsJsonStr != null
        ? jsonDecode(settingsJsonStr) as Map<String, dynamic>
        : null;
    var settings = settingsJson != null
        ? Settings.fromJson(settingsJson)
        : Settings.createDefault();
    return settings;
  }

  @override
  Future<void> update(Settings settings) =>
      _prefs.setString(_settingsKey, jsonEncode(settings.toJson()));
}
