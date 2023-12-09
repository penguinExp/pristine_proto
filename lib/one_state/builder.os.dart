import 'package:flutter/material.dart';

import 'store.os.dart';

class BuilderOS<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T data) widget;
  final ValueStore<T> store;

  const BuilderOS({Key? key, required this.widget, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: store.notifier,
      builder: (context, value, _) {
        return widget(context, value);
      },
    );
  }
}
