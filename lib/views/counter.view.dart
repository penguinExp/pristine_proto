import 'package:flutter/material.dart';

import '../echo/builder.dart';
import '../echo/store.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final store = ValueStore(
    1,
    callback: (value) => value + 2,
  );

  late final ValueStore store2;

  @override
  void initState() {
    super.initState();

    store2 = ValueStore(1, dependencies: {store});
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    store.defaultDependencies = {store2};
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Counter"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueBuilder(
              store: store,
              widget: (context, data) {
                return Text("store1 $data");
              },
            ),
            const SizedBox(height: 20),
            ValueBuilder(
              store: store2,
              widget: (context, data) {
                return Text("store2 $data");
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Update Values"),
              onPressed: () {
                store2.update((value) {
                  return value + 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
