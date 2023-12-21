import 'package:flutter/material.dart';

import '../features/value_store.store.echo.dart';

///
/// Widget to listen to value store and to rebuild when a value store changes
///
class ValueBuilder<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T state) widget;
  final ValueStore<T> store;

  const ValueBuilder({
    Key? key,
    required this.widget,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: store.listener,
      builder: (context, state, _) {
        return widget(context, state);
      },
    );
  }
}
