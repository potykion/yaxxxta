import 'package:flutter/material.dart';

/// У [IconButton] нельзя менять паддинги => делаем свою икон-батн
class FitIconButton extends StatelessWidget {
  /// Событие нажатия
  final void Function()? onTap;

  /// Иконка
  final Icon icon;

  /// У [IconButton] нельзя менять паддинги => делаем свою икон-батн
  const FitIconButton({
    Key? key,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(20),
        child: Padding(padding: EdgeInsets.all(5), child: icon),
        onTap: onTap,
      );
}
