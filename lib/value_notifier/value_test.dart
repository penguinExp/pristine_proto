import 'package:flutter/material.dart';

import 'value_notifier_proto.dart';

class ValueCounter extends StatefulWidget {
  const ValueCounter({Key? key}) : super(key: key);

  @override
  State<ValueCounter> createState() => _ValueCounterState();
}

class _ValueCounterState extends State<ValueCounter> {
  final valueManager = ValueManager(0);

  @override
  void dispose() {
    super.dispose();
    valueManager.dispose();
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
              stateManager: valueManager,
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
              onPressed: () => valueManager.update((i) => i + 1),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Decrement'),
              onPressed: () => valueManager.update((i) {
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
