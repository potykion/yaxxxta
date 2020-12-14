import 'package:hive/hive.dart';
import '../domain/db.dart';
import '../domain/models.dart';

/// Репо настроек
class SettingsRepo implements BaseSettingsRepo {
  final String _settingsKey = "settingsKey";
  final Box<Map> _habitBox;

  /// @nodoc
  SettingsRepo(this._habitBox);

  @override
  Settings get() {
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
