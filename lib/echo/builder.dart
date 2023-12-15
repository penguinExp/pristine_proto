import 'package:flutter/material.dart';

import 'store.dart';

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

///
/// Widget to listen to stream store and to rebuild when a stream store changes
///
class StreamStoreBuilder<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T state) widget;
  final StreamStore<T> store;

  const StreamStoreBuilder({
    Key? key,
    required this.widget,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.listener,
      initialData: store.state,
      builder: (context, state) {
        // if the new state is null, use the previous state
        // very rare to happen
        return widget(context, state.data ?? store.state);
      },
    );
  }
}
