import 'package:flutter/material.dart';

import '../pristine/controller.dart';
import '../pristine/pristine.dart';
import '../pristine/store.dart';
import '../pristine/store_builder.dart';

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

    controller = Pristine().put(() => CounterController());
  }

  @override
  void dispose() {
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

    counter1 = Store(0, d: (val) {
      return val + counter2.state;
    });

    counter2 = Store(0, dependencies: {counter1});
  }

  @override
  void onDispose() {
    counter1.dispose();
    counter2.dispose();
    super.onDispose();
  }

  void updateCounter2() {
    counter2.update((p0) => p0 + 1);
  }
}
