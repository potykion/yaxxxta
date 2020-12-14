import 'models.dart';

abstract class BaseSettingsRepo {
  Settings getOrCreate();

  Future<void> update(Settings settings);
}
