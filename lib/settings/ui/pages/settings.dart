import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/theme.dart';

import '../../../core/ui/widgets/bottom_nav.dart';
import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/input.dart';
import '../../../deps.dart';
import '../../domain/models.dart';

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
            padVerticalOnly: true,
            children: [
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("Показывать выполненные привычки"),
                value: settings.showCompleted,
                onChanged: (showCompleted) => setSettings(
                  settings.copyWith(showCompleted: showCompleted),
                ),
                checkColor: CustomColors.almostBlack,
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
