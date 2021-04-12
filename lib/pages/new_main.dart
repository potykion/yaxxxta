import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/view_models.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/widgets/core/card.dart';
import 'package:yaxxxta/widgets/core/circular_progress.dart';
import 'package:yaxxxta/widgets/core/date.dart';
import 'package:yaxxxta/logic/core/utils/num.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';

class NewMainPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var habits = useProvider(habitControllerProvider);

    useEffect(() {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        context.read(selectedHabitIdProvider).state = habits[0].id!;

        context
            .read(habitPerformingController.notifier)
            .loadSelectedHabitPerformings(
              context.read(selectedHabitIdProvider).state!,
            );
      });
      return;
    }, []);

    var historyDateState = useState(DateTime.now().date());
    var vmAsyncValue = useProvider(habitDetailsPageVMProvider);

    return vmAsyncValue.maybeWhen(
      data: (vm) {
        var habit = vm.habit;
        var progress = vm.progress;
        var history = vm.history;

        return Scaffold(
          body: PageView.builder(
            itemBuilder: (_, index) => Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i in habits.length.range())
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  color: i == index
                                      ? CustomColors.yellow
                                      : CustomColors.lightGrey,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                  top: MediaQuery.of(context).padding.top + 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        habits[index].title,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: CustomColors.almostBlack,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Opacity(
                          opacity: 0.0,
                          child: IconButton(
                              icon: Icon(Icons.edit), onPressed: () {}),
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(
                                value: 0.3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    CustomColors.green),
                                strokeWidth: 10,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.white,
                                child: Icon(Icons.done, size: 50),
                              ),
                            )
                          ],
                          alignment: Alignment.center,
                        ),
                        IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ContainerCard(
                          children: [
                            Calendar(
                              initial: historyDateState.value,
                              change: (d) => historyDateState.value = d,
                              highlights: history.highlights,
                              hideMonth: true,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.add), onPressed: () {}),
                                IconButton(
                                    icon: Icon(Icons.list), onPressed: () {}),
                                // IconButton(icon: Icon(Icons.search), onPressed: () {}),
                                IconButton(
                                    icon: Icon(Icons.settings), onPressed: () {}),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  bottom: 10,
                ),
              ],
            ),
          ),
        );
      },
      orElse: () => Scaffold(
        body: CenteredCircularProgress(),
      ),
    );
  }
}
