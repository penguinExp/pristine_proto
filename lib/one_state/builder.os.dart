import 'package:flutter/material.dart';

import 'store.os.dart';

class BuilderOS<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T data) widget;
  final OneStore<T> store;

  const BuilderOS({Key? key, required this.widget, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return widget(context, snapshot.data as T);
        } else {
          // Handle loading state or errors if needed
          return Container();
        }
      },
    );
  }
}
