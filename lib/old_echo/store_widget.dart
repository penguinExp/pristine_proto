import 'package:flutter/widgets.dart';

import 'builder.dart';
import 'store.dart';

abstract class PristineStateWidget<T> extends StatefulWidget {
  final T initialValue;
  late final ValueStore<T> valueStore;

  PristineStateWidget({required this.initialValue, Key? key})
      : super(key: key) {
    valueStore = ValueStore<T>(initialValue);
  }

  Widget build(BuildContext context, T state);

  ///
  /// This can be used to dispose any controllers
  ///
  void dispose() {}

  ///
  /// This can be used to init any controllers
  ///
  void init() {}

  @override
  PristineStateWidgetState createState() => PristineStateWidgetState();
}

class PristineStateWidgetState<T> extends State<PristineStateWidget> {
  @override
  void initState() {
    super.initState();

    // init users init call
    widget.init();
  }

  @override
  void dispose() {
    // disposing user's dispose method
    widget.dispose();

    // dispose the default store
    widget.valueStore.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueBuilder(
      store: widget.valueStore,
      widget: (context, data) {
        return widget.build(context, data);
      },
    );
  }
}
