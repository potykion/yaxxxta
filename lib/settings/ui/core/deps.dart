import 'package:hive/hive.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/settings/domain/db.dart';
import '../../domain/models.dart';
import '../../infra/db.dart';

/// Регает hive-box для настроек
Provider<Box<Map>> _settingsBoxProvider =
    Provider((_) => Hive.box<Map>("settings"));

/// Регает репо настроек
Provider<BaseSettingsRepo> settingsRepoProvider =
    Provider((ref) => HiveSettingsRepo(ref.watch(_settingsBoxProvider)));

/// Регает настройки
StateProvider<Settings> settingsProvider = StateProvider(
  (ref) => ref.watch(settingsRepoProvider).get(),
);
