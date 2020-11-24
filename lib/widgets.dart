import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:yaxxxta/view_models.dart';

import 'theme.dart';

class HabitCard extends StatefulWidget {
  final HabitVM vm;
  final int repeatIndex;

  const HabitCard({
    Key key,
    this.vm,
    this.repeatIndex,
  }) : super(key: key);

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  get title => widget.vm.title;

  HabitRepeat get repeat => widget.vm.repeats[widget.repeatIndex];

  get isSingleRepeat => widget.vm.repeats.length == 1;

  get repeatCounter =>
      "${widget.repeatIndex + 1} / ${widget.vm.repeats.length}";

  @override
  Widget build(BuildContext context) => PaddedContainerCard(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            BiggerText(text: title),
            SizedBox(width: 5),
            if (repeat.performTime != null)
              SmallerText(text: repeat.performTimeStr),
            Spacer(),
            if (!isSingleRepeat) SmallerText(text: repeatCounter)
          ],
        ),
        SizedBox(height: 5),
        HabitProgressControl(
          progressPercentage: repeat.progressPercentage,
          progressStr: repeat.progressStr,
          type: repeat.type,
          isSingleRepeat: repeat.isSingle,
        )
      ]);
}

class PaddedContainerCard extends StatelessWidget {
  final List<Widget> children;

  const PaddedContainerCard({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      );
}

class DatePickerItem extends StatelessWidget {
  final DateTime date;
  final Color color;

  const DatePickerItem({Key key, this.date, this.color = Colors.white})
      : super(key: key);

  get dateStr => "${date.day}.\n${date.month}";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: this.color,
        ),
        width: 50,
        child: Center(
          child: Text(
            dateStr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class DateScroll extends StatefulWidget {
  @override
  _DateScrollState createState() => _DateScrollState();
}

class _DateScrollState extends State<DateScroll> {
  int selectedIndex = 0;

  /// Сдвигаем лист-вью на половину экрана + 3 паддинга по 10,
  /// чтобы текущий день был посерединке
  InfiniteScrollController controller = InfiniteScrollController(
    initialScrollOffset: -Get.mediaQuery.size.width / 2 + 3 * 10,
  );

  Random get random => Random();

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 60,
        child: InfiniteListView.builder(
          controller: controller,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: DatePickerItem(
              date: DateTime.now().add(Duration(days: index)),
              color: selectedIndex == index
                  ? CustomColors.yellow
                  : CustomColors.green.withAlpha(random.nextInt(255)),
            ),
          ),
        ),
      );
}

class HabitProgressControl extends StatelessWidget {
  final double progressPercentage;
  final String progressStr;
  final HabitType type;
  final bool isSingleRepeat;

  const HabitProgressControl(
      {Key key,
      this.progressPercentage,
      this.progressStr,
      this.type,
      this.isSingleRepeat})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Container(
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                value: progressPercentage,
                backgroundColor: Color(0xffFAFAFA),
                valueColor: AlwaysStoppedAnimation<Color>(CustomColors.green
                    .withAlpha((progressPercentage * 255).toInt())),
              ),
            ),
          ),
          Positioned(
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                splashRadius: 20,
                icon: type == HabitType.time
                    ? Icon(Icons.play_arrow)
                    : Icon(Icons.done),
                onPressed: () {
                  //  todo type == HabitType.time / repeats
                },
              ),
            ),
          ),
          if (!isSingleRepeat)
            Positioned(
              child: SmallerText(text: progressStr, black: true),
              right: 20,
            )
        ],
      );
}

class SmallerText extends StatelessWidget {
  final String text;
  final bool black;

  const SmallerText({Key key, this.text, this.black = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: black ? CustomColors.almostBlack : CustomColors.grey,
        fontSize: 14,
      ),
    );
  }
}

class BiggerText extends StatelessWidget {
  final String text;

  const BiggerText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: CustomColors.almostBlack,
        ),
      );
}

class BiggestText extends StatelessWidget {
  final String text;

  const BiggestText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: CustomColors.almostBlack,
        ),
      );
}
