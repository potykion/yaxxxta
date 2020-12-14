import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/core/ui/widgets/bottom_nav.dart';
import 'package:yaxxxta/core/ui/widgets/card.dart';
import 'package:yaxxxta/core/ui/widgets/input.dart';
import 'package:yaxxxta/settings/domain/models.dart';
import 'package:yaxxxta/settings/infra/db.dart';

import '../../../deps.dart';

/// Страница с настройками
class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var settingsState = useProvider(settingsProvider);
    var settings = settingsState.state;

    setSettings(Settings newSettings) {
      context.read(settingsProvider).state = newSettings;
      context.read(settingsRepoProvider).update(newSettings);
    }

    return Scaffold(
      body: ListView(
        children: [
          PaddedContainerCard(
            children: [
              SelectableCheckbox(
                initial: settings.showCompleted,
                change: (showCompleted) => setSettings(
                  settings.copyWith(showCompleted: showCompleted),
                ),
                biggerText: "Показывать выполненные привычки",
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
