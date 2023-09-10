import 'package:flutter/material.dart';

class ValueManager<T> {
  late T _state;
  late ValueNotifier<T> _valueNotifier;

  ValueManager(T defaultState) {
    _state = defaultState;
    _valueNotifier = ValueNotifier(_state);
  }

  T get state => _state;

  ValueNotifier<T> get valueNotifier => _valueNotifier;

  void setValue(T value) {
    _state = value;
    _valueNotifier.value = _state;
  }

  void update(T Function(T) updateCallback) {
    setValue(updateCallback(_state));
  }

  void dispose() {
    _valueNotifier.dispose();
  }
}

class ValueWidget<T> extends StatelessWidget {
  final Widget Function(T data) widget;
  final ValueManager<T> stateManager;
  const ValueWidget({
    Key? key,
    required this.widget,
    required this.stateManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: stateManager.valueNotifier,
      builder: (context, value, _) {
        return widget(value);
      },
    );
  }
}
