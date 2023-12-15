import 'package:flutter/material.dart';

import '../old_echo/builder.dart';
import '../old_echo/store.dart';

class SliderView extends StatefulWidget {
  const SliderView({super.key});

  @override
  State<SliderView> createState() => _CounterViewState();
}

class _CounterViewState extends State<SliderView> {
  late final ValueStore store;
  final store2 = ValueStore<double>(1.0, callback: (value) => value + 1);

  @override
  void initState() {
    super.initState();

    store = ValueStore<double>(1, dependencies: {store2});
  }

  @override
  void dispose() {
    store.dispose();
    store2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Sliders"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueBuilder(
              store: store,
              widget: (context, data) {
                return Slider(
                  value: data,
                  min: 1,
                  max: 20,
                  onChanged: (val) {
                    store.set(val);
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            ValueBuilder(
              store: store2,
              widget: (context, data) {
                return Slider(
                  value: data,
                  min: 1,
                  max: 20,
                  onChanged: (_) {},
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Reset"),
              onPressed: () {
                store.set(1);
                store2.set(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
