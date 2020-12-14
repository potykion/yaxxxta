import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../deps.dart';
import '../../../habit/ui/pages/list.dart';
import '../../../settings/ui/pages/settings.dart';

/// Страничка, которая рендерит другие странички
/// в зависимости от выбранного индекса боттом наб бара
class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var pageIndexState = useProvider(pageIndexProvider);

    switch (pageIndexState.state) {
      case 0:
        return HabitListPage();
        break;
      case 1:
        return SettingsPage();
      default:
        throw "Хз как обработать pageIndexState = $pageIndexState";
    }
  }
}
