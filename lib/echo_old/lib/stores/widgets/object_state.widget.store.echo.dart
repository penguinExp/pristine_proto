import 'package:flutter/widgets.dart';

import '../builders/object_builder.store.echo.dart';
import '../features/object_store.store.echo.dart';

abstract class ObjectStateWidget<T> extends StatefulWidget {
  final T state;
  late final ObjectStore<T> store;

  ObjectStateWidget({
    required this.state,
    Key? key,
  }) : super(key: key) {
    store = ObjectStore<T>(state);
  }

  Widget build(BuildContext context, T state);

  ///
  /// This can be used to dispose any controllers
  ///
  void onDispose() {}

  ///
  /// This can be used to dispose any controllers
  ///
  void onInit() {}

  @override
  StreamStateWidgetState createState() => StreamStateWidgetState();
}

class StreamStateWidgetState<T> extends State<ObjectStateWidget> {
  @override
  void initState() {
    super.initState();

    // init users init call
    widget.onInit();
  }

  @override
  void dispose() {
    // disposing user's dispose method
    widget.onDispose();

    // dispose the default store
    widget.store.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ObjectStoreBuilder<T>(
      store: widget.store as ObjectStore<T>,
      widget: (ctx, state) => widget.build(ctx, state),
    );
  }
}
