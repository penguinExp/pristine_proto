import 'package:flutter/material.dart';
import '../builder.os.dart';
import '../store.os.dart';

class SimpleCounterViewOS extends StatefulWidget {
  const SimpleCounterViewOS({super.key});

  @override
  State<SimpleCounterViewOS> createState() => _SimpleCounterViewOSState();
}

class _SimpleCounterViewOSState extends State<SimpleCounterViewOS> {
  final store = ValueStore([1, 2]);

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Counter"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuilderOS(
              store: store,
              widget: (context, data) {
                return Text(data.toString());
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Update Values"),
              onPressed: () {
                store.update((value) {
                  return value..add(3);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
