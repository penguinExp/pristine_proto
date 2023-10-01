import 'package:flutter/widgets.dart';
import 'package:pristine_proto/store.dart';

import 'builder.dart';

abstract class PristineStateWidget<T> extends StatefulWidget {
  final T initialValue;
  late final ValueStore<T> valueStore;

  PristineStateWidget({required this.initialValue, Key? key})
      : super(key: key) {
    valueStore = ValueStore<T>(initialValue);
  }

  Widget build(BuildContext context, T state);

  void update(T newState) {
    valueStore.assign(newState);
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
    return ValueWidget<T>(
      widget: (state) => widget.build(context, state),
      stateManager: widget.valueStore as ValueStore<T>,
    );
  }
}
