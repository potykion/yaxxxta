import 'package:hooks_riverpod/all.dart';
import '../../domain/db.dart';
import '../../domain/models.dart';

/// Контроллер настроек
class SettingsController {
  /// Стейт настроек
  final StateController<Settings> settingsState;

  /// Репо настроек
  final BaseSettingsRepo settingsRepo;

  /// Контроллер настроек
  SettingsController({this.settingsState, this.settingsRepo});

  /// Грузит настройки
  Future<void> loadSettings() async {
    settingsState.state = await settingsRepo.get();
  }
}
