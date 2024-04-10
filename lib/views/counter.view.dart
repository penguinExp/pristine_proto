import 'package:flutter/material.dart';

import '../echo/echo.dart';
// import '../paw/paw.dart';

class CounterController extends EchoController {
  final store = ValueStore(1);

  final store2 = ValueStore(<int>[]);

  @override
  void onInit() {
    store2.setUpdateCallback((value) {
      return value..add(store.state);
    });

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
                // if (_controller.store.state >= 3) {
                //   _controller.store.removeDependency(_controller.store2);
                //   Paw().info('removed dependency from store of store2');
                // }

                // _controller.store.update((value) {
                //   return value + 1;
                // });

                // Paw().warn('This is a warning message');

                // Paw().debug({'key': 'value', 'count': 42});

                const bg = "\x1b[48;5;200m";
                const fg = "\x1b[38;5;15m";
                const escape = "\x1B[0m";

                // ignore: avoid_print
                print("$bg$fg PAW $escape| ");

                // try {
                //   throw UnsupportedError(
                //     "Oops! You've forgotten to implement this feature",
                //   );
                // } catch (e, stackTrace) {
                //   // Log an error with a message, error object, and stack trace
                //   Paw().error(
                //     'An unexpected error occurred',
                //     error: e,
                //     stackTrace: stackTrace,
                //   );
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
