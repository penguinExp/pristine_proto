import 'package:flutter/material.dart';

import 'paw_print/paw_print.dart';
import 'views/counter.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    PawPrint.init(name: "ECHO");

    return MaterialApp(
      title: 'Echo Proto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterView(),
    );
  }
}
