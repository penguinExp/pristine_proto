import 'package:flutter/material.dart';

import 'store.dart';

class StoreBuilder<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T data) widget;
  final Store<T> stateManager;

  const StoreBuilder({
    Key? key,
    required this.widget,
    required this.stateManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: stateManager.stream,
      builder: (context, value, _) {
        return widget(context, value);
      },
    );
  }
}
