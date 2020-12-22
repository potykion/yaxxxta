import 'package:flutter/material.dart';

/// Карточка-контейнер с отступами
class PaddedContainerCard extends StatelessWidget {
  /// Дети :)
  /// Содержимое контейнера
  final List<Widget> children;

  /// Сделать паддинги только по вертикали
  final bool padVerticalOnly;

  /// Создает карточку
  const PaddedContainerCard({
    Key key,
    this.children,
    this.padVerticalOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: padVerticalOnly
                ? EdgeInsets.symmetric(vertical: 16, horizontal: 0)
                : EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      );
}
