import 'package:flutter/material.dart';

import 'pristine/store.dart';
import 'pristine/value_watcher.dart';

class ValueCounter extends StatefulWidget {
  const ValueCounter({Key? key}) : super(key: key);

  @override
  State<ValueCounter> createState() => _ValueCounterState();
}

class _ValueCounterState extends State<ValueCounter> {
  late final ValueStore<int> counter;

  late final ValueStore<String> text;

  @override
  void initState() {
    super.initState();

    counter = ValueStore(0);

    text = ValueStore(
      '0',
      depends: (p0) {
        final text = "Pressed ${counter.state} times";
        return text;
      },
    );
  }

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
            ValueWidget<String>(
              stateManager: text,
              widget: (data) {
                return Text(
                  data,
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
            const SizedBox(height: 20),
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
              onPressed: () {
                counter.update((i) => i + 1);
                text.update((p0) => p0);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Decrement'),
              onPressed: () {
                counter.update((i) {
                  if (i <= 0) {
                    return i;
                  }

                  return i - 1;
                });
                text.update((p0) => p0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
