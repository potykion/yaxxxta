import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../core/ui/widgets/bottom_nav.dart';
import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/padding.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../core/ui/widgets/time.dart';
import '../../../deps.dart';
import '../../../theme.dart';
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
              SmallPadding(
                child: BiggerText(text: "Начало и конец дня"),
              ),
              ListTile(
                title: Row(
                  children: [
                    Flexible(
                      child: TimePickerInput(
                        initial: settings.dayStartTime,
                        change: (time) => setSettings(
                          settings.copyWith(dayStartTime: time),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: TimePickerInput(
                        initial: settings.dayEndTime,
                        change: (time) => setSettings(
                          settings.copyWith(dayEndTime: time),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          PaddedContainerCard(
            padVerticalOnly: true,
            children: [
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: BiggerText(text: "Показывать выполненные привычки"),
                value: settings.showCompleted,
                onChanged: (showCompleted) => setSettings(
                  settings.copyWith(showCompleted: showCompleted),
                ),
                checkColor: CustomColors.almostBlack,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
