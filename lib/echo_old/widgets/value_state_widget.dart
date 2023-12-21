import 'package:flutter/widgets.dart';

import '../builder.dart';
import '../store.dart';

abstract class ValueStateWidget<T> extends StatefulWidget {
  final T state;
  late final ValueStore<T> valueStore;

  ValueStateWidget({
    required this.state,
    Key? key,
  }) : super(key: key) {
    valueStore = ValueStore<T>(state);
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
  ValueStateWidgetState createState() => ValueStateWidgetState();
}

class ValueStateWidgetState<T> extends State<ValueStateWidget> {
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
    widget.valueStore.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueBuilder<T>(
      store: widget.valueStore as ValueStore<T>,
      widget: (ctx, state) => widget.build(ctx, state),
    );
  }
}
