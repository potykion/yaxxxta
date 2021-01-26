import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/settings/domain/db.dart';
import 'package:yaxxxta/settings/domain/models.dart';

class SettingsController {
  final StateController<Settings> settingsState;
  final BaseSettingsRepo settingsRepo;

  SettingsController({this.settingsState, this.settingsRepo});

  Future<void> loadSettings() async {
    settingsState.state = await settingsRepo.get();
  }
}
