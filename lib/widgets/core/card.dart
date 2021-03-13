import 'package:flutter/material.dart';

/// Карточка-контейнер
class ContainerCard extends StatelessWidget {
  /// Содержимое контейнера
  final List<Widget> children;

  /// Карточка-контейнер
  const ContainerCard({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
