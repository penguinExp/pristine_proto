import 'package:flutter/material.dart';

import 'store.dart';

class ValueWidget<T> extends StatelessWidget {
  final Widget Function(T data) widget;
  final ValueStore<T> stateManager;
  const ValueWidget({
    Key? key,
    required this.widget,
    required this.stateManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: stateManager.stream,
      builder: (context, value, _) {
        return widget(value);
      },
    );
  }
}
