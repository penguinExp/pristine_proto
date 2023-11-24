import 'package:flutter/material.dart';
import '../builder.os.dart';
import '../store.os.dart';

class User {
  String name = "one";
}

class SimpleCounterViewOS extends StatefulWidget {
  const SimpleCounterViewOS({super.key});

  @override
  State<SimpleCounterViewOS> createState() => _SimpleCounterViewOSState();
}

class _SimpleCounterViewOSState extends State<SimpleCounterViewOS> {
  final counterStore = OneStore(0);
  final listStore = OneStore([1, 2]);
  final userStore = OneStore(User());

  @override
  void dispose() {
    counterStore.dispose();
    listStore.dispose();
    userStore.dispose();

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
              store: userStore,
              widget: (context, data) {
                return Text(data.name.toString());
              },
            ),
            const SizedBox(height: 20),
            BuilderOS(
              store: counterStore,
              widget: (context, data) {
                return Text(data.toString());
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Update Values"),
              onPressed: () {
                // counterStore.updateWith((val) => val + 2);
                // listStore.updateWith((p0) => p0..add(2));
                userStore.updateWith((p0) => p0..name = "two");
              },
            ),
          ],
        ),
      ),
    );
  }
}
