import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/habit/ui/pages/list.dart';
import 'package:yaxxxta/settings/ui/pages/settings.dart';

import '../../../deps.dart';

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
