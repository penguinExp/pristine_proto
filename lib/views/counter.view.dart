import 'package:flutter/material.dart';
import '../old_echo/controller.dart';
import '../old_echo/echo.dart';

import '../old_echo/builder.dart';
import '../old_echo/store.dart';

class CounterController extends EchoController {
  final store = ValueStore(
    1,
    callback: (value) => value + 2,
  );

  late final ValueStore store2;

  @override
  void onInit() {
    super.onInit();

    store2 = ValueStore(1, dependencies: {store});
  }

  @override
  void onDispose() {
    super.onDispose();

    store.dispose();
    store2.dispose();
  }
}

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late final CounterController _controller;

  @override
  void initState() {
    super.initState();

    _controller = echo.put(() => CounterController());
  }

  @override
  void dispose() {
    echo.delete(_controller);

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
            ValueBuilder(
              store: _controller.store,
              widget: (context, data) {
                return Text("store1 $data");
              },
            ),
            const SizedBox(height: 20),
            ValueBuilder(
              store: _controller.store2,
              widget: (context, data) {
                return Text("store2 $data");
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Update Values"),
              onPressed: () {
                _controller.store2.update((value) {
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
