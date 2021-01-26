import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/core/ui/widgets/text.dart';
import 'package:yaxxxta/settings/ui/core/deps.dart';

import '../../../routes.dart';

/// Страничка, на которой подгружается все необходимое
class LoadingPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await context.read(settingsControllerProvider).loadSettings();

        Navigator.pushReplacementNamed(context, Routes.list);
      });
    }, []);

    return Scaffold(
      body: Center(child: BiggerText(text: "Ща все буит...")),
    );
  }
}
