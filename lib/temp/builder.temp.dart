import 'package:flutter/material.dart';

import 'store.temp.dart';

class BuilderOS<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T data) widget;
  final OneStore<T> store;

  const BuilderOS({Key? key, required this.widget, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: store.state,
      builder: (context, value, _) {
        return widget(context, value);
      },
      
    );
  }
}
