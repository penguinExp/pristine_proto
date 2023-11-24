import 'package:flutter/material.dart';

import '../controller.dart';
import '../pristine.dart';
import '../store.dart';
import '../store_builder.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late final CounterController controller;

  @override
  void initState() {
    super.initState();

    // init the controller
    controller = Pristine().put(() => CounterController());
  }

  @override
  void dispose() {
    // TODO: Need to test by manually deleting the controller
    Pristine().delete<CounterController>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StoreBuilder(
                stateManager: controller.counter1,
                widget: (ctx, data) {
                  return Text(data.toString());
                },
              ),
              const SizedBox(
                height: 10,
              ),
              StoreBuilder(
                stateManager: controller.counter2,
                widget: (ctx, data) {
                  return Text(data.toString());
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: controller.updateCounter2,
                child: const Text("Update Counter"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CounterController extends PristineController {
  late final Store<int> counter1;
  late final Store<int> counter2;

  @override
  void onInit() {
    super.onInit();

    // Counter-1 depends on counter-2's value,
    // when counter-2 updates it will update automatically
    // the `d` represents how it'll be updated
    counter1 = Store(0, d: (val) {
      return val + counter2.state;
    });

    // when this controller will update then its dependencies will automatically will be updated
    counter2 = Store(0, dependencies: {counter1});
  }

  @override
  void onDispose() {
    // user manually needs to dispose off the controllers
    counter1.dispose();
    counter2.dispose();
    super.onDispose();
  }

  // Can update the value of the controller depending on its current value
  void updateCounter2() {
    counter2.update((p0) => p0 + 1);
  }

  // Can also update the value of the controller directly
  void resetCounter1() {
    counter1.assign(0);
  }
}
