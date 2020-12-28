// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/all.dart';
// import 'package:yaxxxta/deps.dart';
//
// import '../../../core/ui/widgets/card.dart';
// import '../../../core/ui/widgets/date.dart';
// import '../../../core/ui/widgets/text.dart';
// import '../../../core/utils/dt.dart';
// import '../../../routes.dart';
// import '../../../theme.dart';
// import '../../domain/models.dart';
// import 'deps.dart';
// import 'widgets.dart';
//
// enum HabitActionType { edit, delete }
//
// /// Страничка с инфой о привычке
// class HabitDetailsPage extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     var vm = useProvider(habitDetailsController.state);
//     var selectedDateState = useState(DateTime.now().date());
//
//     return Scaffold(
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: Row(
//               children: [
//                 IconButton(
//                     icon: Icon(Icons.arrow_back),
//                     onPressed: () => Navigator.of(context).pop()),
//                 BiggestText(text: vm.habit.title),
//                 Spacer(),
//                 IconButton(
//                     icon: Icon(Icons.more_vert),
//                     onPressed: () async {
//                       var actionType =
//                           await showModalBottomSheet<HabitActionType>(
//                         context: context,
//                         builder: (context) => Container(
//                           height: 170,
//                           child: ListView(
//                             children: [
//                               ListTile(
//                                 title:
//                                     BiggerText(text: "Что делаем с привычкой?"),
//                               ),
//                               ListTile(
//                                 title: Text("Редактируем"),
//                                 onTap: () => Navigator.of(context)
//                                     .pop(HabitActionType.edit),
//                               ),
//                               ListTile(
//                                 title: Text("Удаляем"),
//                                 onTap: () => Navigator.of(context)
//                                     .pop(HabitActionType.delete),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//
//                       if (actionType == HabitActionType.edit) {
//                         Navigator.of(context)
//                             .pushNamed(Routes.form, arguments: vm.habit.id);
//                       } else if (actionType == HabitActionType.delete) {
//                         var isDelete = await showModalBottomSheet<bool>(
//                           context: context,
//                           builder: (context) => Container(
//                             height: 170,
//                             child: ListView(
//                               children: [
//                                 ListTile(
//                                   title: BiggerText(text: "Точно удаляем?"),
//                                 ),
//                                 ListTile(
//                                   title: Text("Да"),
//                                   onTap: () => Navigator.of(context).pop(true),
//                                 ),
//                                 ListTile(
//                                   title: Text("Не"),
//                                   onTap: () => Navigator.of(context).pop(false),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                         if (isDelete != null && isDelete) {
//                           context.read(habitRepoProvider).delete(vm.habit.id);
//                           //  todo бля тут тож надо стейт в списке изменить
//                           Navigator.of(context).pop();
//                         }
//                       } else {
//                         //  ничо не делаем
//                       }
//                     })
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Wrap(
//               spacing: 5,
//               children: [
//                 Chip(
//                   label: Text(vm.habit.type.verbose()),
//                   backgroundColor: CustomColors.blue,
//                 ),
//                 Chip(
//                   label: Text(vm.habit.habitPeriod.type.verbose()),
//                   backgroundColor: CustomColors.red,
//                 ),
//                 // Chip(label: Text("Спорт"), backgroundColor: CustomColors.pink),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 130,
//             child: PageView.builder(
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) => ProviderScope(
//                 overrides: [repeatIndexProvider.overrideWithValue(index)],
//                 child: PaddedContainerCard(
//                   children: [
//                     BiggerText(text: "Сегодня"),
//                     SizedBox(height: 5),
//                     HabitDetailsProgressControl(),
//                   ],
//                 ),
//               ),
//               itemCount: vm.habit.dailyRepeats.toInt(),
//               // controller: PageController(
//               //   initialPage: vm.firstIncompleteRepeatIndex,
//               // ),
//             ),
//           ),
//           PaddedContainerCard(
//             children: [
//               BiggerText(text: "История"),
//               SizedBox(height: 5),
//               DatePicker(
//                 change: (d) => selectedDateState.value = d,
//                 highlights: vm.historyHighlights,
//               ),
//               if (vm.history.containsKey(selectedDateState.value))
//                 for (var e in vm.history[selectedDateState.value])
//                   Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Row(children: [
//                       SmallerText(
//                         text: formatTime(e.time),
//                         dark: true,
//                       ),
//                       Spacer(),
//                       SmallerText(
//                         text: "+ ${e.format(HabitType.time)}",
//                         dark: true,
//                       )
//                     ]),
//                   )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
