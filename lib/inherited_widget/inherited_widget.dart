import 'package:flutter/material.dart';

class AppState<T> {
  late T _state;

  AppState(T defaultValue) {
    _state = defaultValue;
  }

  T get state => _state;

  void setValue(T value) {
    _state = value;
  }

  void update(T Function(T) updateCallback) {
    setValue(updateCallback(_state));
  }
}

// Create an inherited widget to provide access to the state
class AppStateProvider<T> extends InheritedWidget {
  final Widget Function() widget;
  final AppState<T> stateManager;

   AppStateProvider(
      {super.key, required this.stateManager, required this.widget})
      : super(child: widget());

  static AppStateProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
  }

  @override
  bool updateShouldNotify(AppStateProvider oldWidget) {
    return oldWidget.stateManager.state != stateManager.state;
  }
}
