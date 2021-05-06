import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/widgets/habit_list_tile.dart';
import 'package:yaxxxta/widgets/habit_performing_card.dart';
import 'package:yaxxxta/widgets/pagination.dart';
import 'package:yaxxxta/widgets/web_padding.dart';
import 'package:yaxxxta/routes.gr.dart';
import 'package:yaxxxta/widgets/calendar_app_bar.dart';
import 'package:auto_route/auto_route.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, size) => WebPadding(
          child: size.maxWidth > 600 ? CalendarWebPage() : CalendarAppPage(),
        ),
      );
}

var _selectedHabitIndexProvider = StateProvider((ref) => 0);

class CalendarWebPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var selectedHabitIndex = useProvider(_selectedHabitIndexProvider).state;

    var pageController =
        useMemoized(() => PageController(initialPage: selectedHabitIndex));
    useEffect(() {
      updateIndex() {
        context.read(_selectedHabitIndexProvider).state =
            pageController.page!.toInt();
      }

      pageController.addListener(updateIndex);
      return () => pageController.removeListener(updateIndex);
    }, []);
    useValueChanged<int, void>(selectedHabitIndex, (_, __) {
      if (selectedHabitIndex == pageController.page) return;
      pageController.jumpToPage(selectedHabitIndex);
    });

    var vms = useProvider(habitVMsProvider);

    List<Widget> children = List.generate(vms.length, (index) => index)
        .map(
          (index) => HabitListTile(
            vm: vms[index],
            index: index,
            onTap: () =>
                context.read(_selectedHabitIndexProvider).state = index,
            isSelected: selectedHabitIndex == index,
          ),
        )
        .toList();

    return Scaffold(
      appBar: buildCalendarAppBar(context),
      body: Row(
        children: [
          Flexible(child: ListView(children: children)),
          VerticalDivider(),
          Flexible(
            child: PageView.builder(
              itemCount: vms.length,
              scrollDirection: Axis.vertical,
              controller: pageController,
              itemBuilder: (_, index) => HabitPerformingCard(
                vm: vms[index],
                onPerform: () {
                  var nextIndex = getNextUnperformedHabitIndex(
                    vms,
                    initialIndex: index,
                  );
                  if (nextIndex != -1) {
                    context.read(_selectedHabitIndexProvider).state = nextIndex;
                  }
                },
              ),
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }
}

class CalendarAppPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useProvider(habitVMsProvider);

    var currentIndex = useState(0);
    var controller = useState(SwiperController());
    // При открытии аппа скроллим на первую невыполненную привычку
    useEffect(
      () {
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          var nextIndex = getNextUnperformedHabitIndex(
            vms,
            initialIndex: 0,
            includeInitial: true,
          );
          if (nextIndex != -1) {
            currentIndex.value = nextIndex;
            controller.value.move(nextIndex);
          }
        });
      },
      [],
    );

    return Scaffold(
      appBar: buildCalendarAppBar(context, extraActions: [
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () async {
            var index =
                await AutoRouter.of(context).push(ListHabitRoute()) as int?;
            if (index != null) {
              currentIndex.value = index;
              controller.value.move(index);
            }
          },
        ),
      ]),
      body: vms.isEmpty
          ? Center(child: Text("Привычки не найдены"))
          : Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: HabitPagination(
                    vms: vms,
                    currentIndex: currentIndex.value,
                  ),
                ),
                Swiper(
                  controller: controller.value,
                  onIndexChanged: (index) => currentIndex.value = index,
                  key: ValueKey(vms.length),
                  itemCount: vms.length,
                  itemBuilder: (context, index) {
                    var vm = vms[index];

                    return HabitPerformingCard(
                      vm: vm,
                      onPerform: () {
                        var nextIndex = getNextUnperformedHabitIndex(
                          vms,
                          initialIndex: index,
                        );
                        if (nextIndex != -1) {
                          currentIndex.value = nextIndex;
                          controller.value.move(nextIndex);
                        }
                      },
                      onArchive: () {
                        currentIndex.value = 0;
                        controller.value.move(0);
                      },
                    );
                  },
                )
              ],
            ),
    );
  }
}
