import 'package:hive/hive.dart';
import 'package:yaxxxta/settings/domain/db.dart';
import 'package:yaxxxta/settings/domain/models.dart';

class SettingsRepo implements BaseSettingsRepo {
  final String settingsKey = "settingsKey";
  final Box<Map> _habitBox;

  SettingsRepo(this._habitBox);

  @override
  Settings getOrCreate() {
    var settingsJson = _habitBox.get(settingsKey);
    var settings = settingsJson != null
        ? Settings.fromJson(settingsJson)
        : Settings.createDefault();
    return settings;
  }

  @override
  Future<void> update(Settings settings) =>
      _habitBox.put(settingsKey, settings.toJson());
}
