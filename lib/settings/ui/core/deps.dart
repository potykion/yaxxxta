import 'package:hooks_riverpod/all.dart';
import '../../domain/db.dart';
import '../../domain/models.dart';
import '../../infra/db.dart';
import 'controllers.dart';

/// Регает репо настроек
Provider<BaseSettingsRepo> settingsRepoProvider = Provider(
  (ref) => SharedPreferencesSettingsRepo(),
);

/// Регает настройки
StateProvider<Settings> settingsProvider = StateProvider((ref) => null);

/// Провайдер котроллера настроек
Provider<SettingsController> settingsControllerProvider = Provider(
  (ref) => SettingsController(
    settingsState: ref.watch(settingsProvider),
    settingsRepo: ref.watch(settingsRepoProvider),
  ),
);
