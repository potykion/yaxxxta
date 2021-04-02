import 'package:flutter/material.dart';
import 'package:yaxxxta/widgets/core/loading_button.dart';
import 'package:yaxxxta/widgets/core/text.dart';

/// Страничка для экспериментов
class PlaygroundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: LoadingButton(
        onTapFuture: () async {
          await Future<void>.delayed(Duration(seconds: 3));
        },
        child: BiggerText(text: 'Загрузить'),
      )),
    );
  }
}
