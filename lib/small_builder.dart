import 'package:flutter/widgets.dart';
import 'package:pristine_proto/store.dart';

import 'builder.dart';

abstract class PristineStateWidget<T> extends StatefulWidget {
  final T initialValue;

  const PristineStateWidget({required this.initialValue, Key? key})
      : super(key: key);

  Widget build(BuildContext context, T state);

  void update() {}

  void dispose() {}

  @override
  String toStringShort() {
    return 'PristineStateWidget';
  }

  @override
  PristineStateWidgetState createState() => PristineStateWidgetState();
}

class PristineStateWidgetState<T> extends State<PristineStateWidget> {
  late final ValueStore<T> valueStore;

  @override
  void initState() {
    super.initState();

    // valueStore = ValueStore<T>(widget.initialValue);
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueWidget<T>(
        widget: (state) => widget.build(context, state),
        stateManager: valueStore);
  }
}

// This is the example of the slider widget
class SliderWidget extends PristineStateWidget<int> {
  const SliderWidget({Key? key}) : super(key: key, initialValue: 0);

  @override
  Widget build(BuildContext context, int state) {
    return Text(state.toString());
  }
}
