import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/new/controllers.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/widgets/core/circular_progress.dart';
import 'package:yaxxxta/logic/core/utils/num.dart';
import 'package:yaxxxta/logic/core/utils/list.dart';

class NewMainPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var habits = useProvider(habitControllerProvider);
    var habitPerformingsValue =
        useProvider(newHabitPerformingControllerProvider);

    return Scaffold(
      body: PageView.builder(
        itemCount: habits.length,
        onPageChanged: (index) => context
            .read(newHabitPerformingControllerProvider.notifier)
            .load(habits[index].id!),
        itemBuilder: (_, index) => habitPerformingsValue.maybeWhen(
          data: (habitPerformings) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (var i in habits.length.range())
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 8,
                              height: 8,
                              color: i == index
                                  ? CustomColors.almostBlack
                                  : CustomColors.grey.withAlpha(47),
                            ),
                          )
                      ]
                          .joinObject(
                              Padding(padding: EdgeInsets.only(right: 4)))
                          .toList(),
                    ),
                  ),
                  top: MediaQuery.of(context).padding.top + 10,
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          habits[index].title,
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            child: Icon(Icons.done),
                            onPressed: () {},
                            backgroundColor: Colors.white,
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
                              Container(
                                width: 84,
                                height: 84,
                                child: FittedBox(
                                  child: FloatingActionButton(
                                    // elevation: 0,
                                    onPressed: () {},
                                    child: Text(
                                      "+1",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              )
                            ],
                            alignment: Alignment.center,
                          ),
                          FloatingActionButton(
                            onPressed: () {},
                            child: Icon(Icons.edit),
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      // Calendar30Days(
                      //   initial: historyDateState.value,
                      //   change: (d) => historyDateState.value = d,
                      //   highlights: history.highlights,
                      //   hideMonth: true,
                      // ),
                      SizedBox(height: 8),
                      Material(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.add),
                                    onPressed: () {}),
                                FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.list),
                                    onPressed: () {}),
                                FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.settings),
                                    onPressed: () {}),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  bottom: 10,
                ),
              ],
            );
          },
          orElse: () => Scaffold(
            body: CenteredCircularProgress(),
          ),
        ),
      ),
    );
  }
}
