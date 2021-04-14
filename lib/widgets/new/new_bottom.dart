import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:yaxxxta/theme.dart';

import '../../routes.dart';

class NewBottomBar extends StatelessWidget {
  var actions = [
    Tuple2(Icons.today, Routes.newMain),
    Tuple2(Icons.add, Routes.form),
    Tuple2(Icons.list, Routes.list),
    Tuple2(Icons.settings, Routes.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,

            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var action in actions)
                        FloatingActionButton(
                          elevation: 0,
                          backgroundColor:
                              ModalRoute.of(context)!.settings.name ==
                                      action.item2
                                  ? CustomColors.yellow
                                  : Colors.white,
                          child: Icon(action.item1),
                          onPressed: () => Navigator.pushNamed(
                            context,
                            action.item2,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
