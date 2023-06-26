import 'package:flutter/material.dart';

import 'stream_proto.dart';

final stateManager = StateManager<int>(0);

class StreamCounter extends StatelessWidget {
  const StreamCounter({Key? key}) : super(key: key);

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
            StateWidget<int>(
              stateManager: stateManager,
              child: (data) {
                return Text(
                  'Counter: $data',
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Increment'),
              onPressed: () => stateManager.update((i) => i + 1),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Decrement'),
              onPressed: () => stateManager.update((i) {
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
