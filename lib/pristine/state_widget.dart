import 'package:flutter/widgets.dart';
import 'store_builder.dart';
import 'store.dart';

abstract class PristineStateWidget<T> extends StatefulWidget {
  final T initialValue;
  late final Store<T> valueStore;

  PristineStateWidget({required this.initialValue, Key? key})
      : super(key: key) {
    valueStore = Store<T>(initialValue);
  }

  Widget build(BuildContext context, T state);

  void assign(T newState) {
    valueStore.assign(newState);
  }

  ///
  /// This can be used to dispose any controllers
  ///
  void dispose() {}

  ///
  /// This can be used to dispose any controllers
  ///
  void init() {}

  @override
  String toStringShort() {
    return 'PristineStateWidget';
  }

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
    return StoreBuilder<T>(
      widget: (ctx, state) => widget.build(ctx, state),
      stateManager: widget.valueStore as Store<T>,
    );
  }
}
