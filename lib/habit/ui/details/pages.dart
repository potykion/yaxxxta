import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/date.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../core/utils/dt.dart';
import '../../../theme.dart';
import '../../domain/models.dart';
import 'deps.dart';
import 'widgets.dart';

/// Страничка с инфой о привычке
class HabitDetailsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vm = useProvider(habitDetailsController.state);
    var selectedDateState = useState(DateTime.now().date());

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop()),
                BiggestText(text: vm.habit.title),
                Spacer(),
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              spacing: 5,
              children: [
                Chip(
                  label: Text(vm.habit.type.verbose()),
                  backgroundColor: CustomColors.blue,
                ),
                Chip(
                  label: Text(vm.habit.habitPeriod.type.verbose()),
                  backgroundColor: CustomColors.red,
                ),
                // Chip(label: Text("Спорт"), backgroundColor: CustomColors.pink),
              ],
            ),
          ),
          SizedBox(
            height: 130,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProviderScope(
                overrides: [repeatIndexProvider.overrideWithValue(index)],
                child: PaddedContainerCard(
                  children: [
                    BiggerText(text: "Сегодня"),
                    SizedBox(height: 5),
                    HabitDetailsProgressControl(),
                  ],
                ),
              ),
              itemCount: vm.habit.dailyRepeats.toInt(),
              // controller: PageController(
              //   initialPage: vm.firstIncompleteRepeatIndex,
              // ),
            ),
          ),
          PaddedContainerCard(
            children: [
              BiggerText(text: "История"),
              SizedBox(height: 5),
              DatePicker(
                change: (d) => selectedDateState.value = d,
                highlights: vm.historyHighlights,
              ),
              if (vm.history.containsKey(selectedDateState.value))
                for (var e in vm.history[selectedDateState.value])
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(children: [
                      SmallerText(
                        text: formatTime(e.time),
                        dark: true,
                      ),
                      Spacer(),
                      SmallerText(
                        text: "+ ${e.format(HabitType.time)}",
                        dark: true,
                      )
                    ]),
                  )
            ],
          ),
        ],
      ),
    );
  }
}
