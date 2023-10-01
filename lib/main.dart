import 'package:flutter/material.dart';
import 'state_widget.dart';
import 'store.dart';

import 'builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pristine Proto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterView(),
    );
  }
}

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final counter = ValueStore<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ValueWidget<int>(
            //   widget: (value) => Text('$value'),
            //   stateManager: counter,
            // ),
            // const SizedBox(height: 50),
            // ElevatedButton(
            //   child: const Text('Increment'),
            //   onPressed: () {
            //     counter.update((p0) {
            //       return p0 + 1;
            //     });
            //   },
            // ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   child: const Text('Reset'),
            //   onPressed: () {
            //     counter.assign(0);
            //   },
            // ),
            CounterWidget(),
          ],
        ),
      ),
    );
  }
}

// This is the example of the slider widget
class CounterWidget extends PristineStateWidget<int> {
  CounterWidget({Key? key}) : super(key: key, initialValue: 0);

  @override
  Widget build(BuildContext context, int state) {
    return Column(
      children: [
        Text(state.toString()),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          child: const Text("Button"),
          onPressed: () {
            update(state + 1);
          },
        ),
      ],
    );
  }
}
