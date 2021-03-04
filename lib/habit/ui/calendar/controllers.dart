
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Стейт анимированного списка на странице календаря
// ignore: camel_case_types
class HabitCalendarPage_AnimatedListState
    extends StateNotifier<GlobalKey<AnimatedListState>?> {
  /// Стейт анимированного списка на странице календаря
  HabitCalendarPage_AnimatedListState(
    GlobalKey<AnimatedListState> state,
  ) : super(state);

  /// Удаляет позицию из списка
  void removeItem(
    int index,
    Widget Function(BuildContext, Animation<double>) itemBuilder,
  ) {
    state!.currentState!.removeItem(
      index,
      itemBuilder,
      duration: Duration(milliseconds: 500),
    );
  }

  /// Добавляет позицию из списка
  void insertItem(int index) {
    state!.currentState!.insertItem(
      index,
      duration: Duration(milliseconds: 500),
    );
  }

  /// Сбрасывает состояние
  /// todo зач этот метод нужен
  void reset({bool delete = false}) {
    state = delete ? null : GlobalKey<AnimatedListState>();
  }
}
