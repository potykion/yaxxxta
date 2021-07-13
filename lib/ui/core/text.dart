import 'package:flutter/material.dart';

class Headline4 extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const Headline4(
    this.text, {
    Key? key,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.headline4!.merge(style),
      );
}

class Headline5 extends StatelessWidget {
  final String text;
  final Widget? trailing;
  final TextStyle? style;
  final bool center;

  const Headline5(
    this.text, {
    Key? key,
    this.trailing,
    this.style,
    this.center = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            center ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline5!.merge(style),
          ),
          if (trailing != null) trailing!
        ],
      );
}

class Headline6 extends StatelessWidget {
  final String text;
  final bool white;

  const Headline6(this.text, {Key? key, this.white = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.headline6!;
    if (white) {
      style = style.copyWith(color: Colors.white);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text, style: style),
    );
  }
}

class Caption extends StatelessWidget {
  final String text;

  const Caption(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Text(text, style: TextStyle(color: Colors.grey));
}
