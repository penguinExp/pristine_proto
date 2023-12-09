import 'package:flutter/material.dart';

import 'store.dart';

class ValueBuilder<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T data) widget;
  final ValueStore<T> store;

  const ValueBuilder({Key? key, required this.widget, required this.store})
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

class ObjectBuilder<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T data) widget;
  final ObjectStore<T> store;

  const ObjectBuilder({Key? key, required this.widget, required this.store})
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
