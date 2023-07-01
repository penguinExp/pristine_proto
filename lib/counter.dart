import 'package:flutter/material.dart';
import 'package:pristine_proto/pristine/store.dart';

import 'pristine/value_watcher.dart';

class ValueCounter extends StatefulWidget {
  const ValueCounter({Key? key}) : super(key: key);

  @override
  State<ValueCounter> createState() => _ValueCounterState();
}

class _ValueCounterState extends State<ValueCounter> {
  final ValueStore<int> counter = ValueStore(0);
  final ValueStore<String> text = ValueStore('0');

  @override
  void dispose() {
    super.dispose();
    counter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueWidget<int>(
              stateManager: counter,
              widget: (data) {
                return Text(
                  'Counter: $data',
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Increment'),
              onPressed: () => counter.update((i) => i + 1),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Decrement'),
              onPressed: () => counter.update((i) {
                if (i <= 0) {
                  return i;
                }

                return i - 1;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
