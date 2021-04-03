import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/widgets/core/circular_progress.dart';

/// Кнопка, при нажатии на которую появляется спиннер
class LoadingButton extends HookWidget {
  /// Дочерний виджет
  final Widget child;

  /// Событие-фьюча нажатия на кнопку
  final Future Function() onTapFuture;

  /// Кнопка, при нажатии на которую появляется спиннер
  const LoadingButton({
    Key? key,
    required this.child,
    required this.onTapFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loadingState = useState(false);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: loadingState.value
            ? SizedBox(
                height: 20,
                width: 20,
                child: CenteredCircularProgress(),
              )
            : child,
        onPressed: loadingState.value
            ? null
            : () async {
                loadingState.value = true;
                await onTapFuture();
                loadingState.value = false;
              },
      ),
    );
  }
}
