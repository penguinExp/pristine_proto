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
    valueStore.update((p0) {
      return newState;
    });
  }

  void update(T Function(T) updateCallback) {
    valueStore.update(updateCallback);
  }

  void dispose() {}

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
  }

  @override
  void dispose() {
    widget.dispose();
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
