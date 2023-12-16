import 'package:flutter/widgets.dart';

import '../builder.dart';
import '../store.dart';

abstract class StreamStateWidget<T> extends StatefulWidget {
  final T state;
  late final StreamStore<T> store;

  StreamStateWidget({
    required this.state,
    Key? key,
  }) : super(key: key) {
    store = StreamStore<T>(state);
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

class StreamStateWidgetState<T> extends State<StreamStateWidget> {
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
    return StreamStoreBuilder<T>(
      store: widget.store as StreamStore<T>,
      widget: (ctx, state) => widget.build(ctx, state),
    );
  }
}
