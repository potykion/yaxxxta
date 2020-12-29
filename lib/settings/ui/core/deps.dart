import 'package:hive/hive.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/settings/domain/models.dart';
import 'package:yaxxxta/settings/infra/db.dart';

/// Регает hive-box для настроек
Provider<Box<Map>> _settingsBoxProvider =
    Provider((_) => Hive.box<Map>("settings"));

/// Регает репо настроек
Provider<SettingsRepo> settingsRepoProvider =
    Provider((ref) => SettingsRepo(ref.watch(_settingsBoxProvider)));

/// Регает настройки
StateProvider<Settings> settingsProvider = StateProvider(
  (ref) => ref.watch(settingsRepoProvider).get(),
);
