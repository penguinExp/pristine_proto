import 'package:flutter/material.dart';

import '../pristine/store.dart';
import '../pristine/store_builder.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final Store<int> counter = Store<int>(0, d: (p0) {
    return p0 + 2;
  });

  late final Store<int> counter_2;

  void updateCounter() {
    counter_2.update((p0) => p0 + 1);
  }

  @override
  void initState() {
    super.initState();

    counter_2 = Store<int>(0, dependencies: {counter});
  }

  @override
  void dispose() {
    counter.dispose();

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
                stateManager: counter_2,
                widget: (ctx, data) {
                  return Text(data.toString());
                },
              ),
              const SizedBox(
                height: 10,
              ),
              StoreBuilder(
                stateManager: counter,
                widget: (ctx, data) {
                  return Text(data.toString());
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: updateCounter,
                child: const Text("Update Counter"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
