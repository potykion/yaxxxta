import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';

class HabitCalendarPage_AnimatedListState
    extends StateNotifier<GlobalKey<AnimatedListState>> {
  HabitCalendarPage_AnimatedListState(
    GlobalKey<AnimatedListState> state,
  ) : super(state);

  void removeItem(
    int index,
    Widget Function(BuildContext, Animation<double>) itemBuilder,
  ) {
    state.currentState.removeItem(
      index,
      itemBuilder,
      duration: Duration(milliseconds: 500),
    );
  }

  void insertItem(int index) {
    state.currentState.insertItem(
      index,
      duration: Duration(milliseconds: 500),
    );
  }

  void reset({bool delete = false}) {
    state = delete ? null : GlobalKey<AnimatedListState>();
  }
}
