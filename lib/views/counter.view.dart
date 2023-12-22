import 'package:flutter/material.dart';

import '../echo/echo.dart';

class CounterController extends EchoController {
  final store = ValueStore(1);

  late final ObjectStore store2;

  @override
  void onInit() {
    store2 = ObjectStore(
      [],
      updateCallback: (value) {
        return value..add(store.state);
      },
    );

    store.addDependency(store2);
  }

  @override
  void onDispose() {
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

  final Echo _echo = Echo();

  @override
  void initState() {
    super.initState();

    _controller = _echo.put(() => CounterController());
  }

  @override
  void dispose() {
    _echo.delete(_controller);

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
            ObjectStoreBuilder(
              store: _controller.store2,
              widget: (context, data) {
                return Text("store2 $data");
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Update Values"),
              onPressed: () {
                _controller.store.update((value) {
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
