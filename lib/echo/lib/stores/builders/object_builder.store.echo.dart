import 'package:flutter/material.dart';

import '../features/object_store.store.echo.dart';

///
/// Widget to listen to stream store and to rebuild when a stream store changes
///
class ObjectStoreBuilder<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T state) widget;
  final ObjectStore<T> store;

  const ObjectStoreBuilder({
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
