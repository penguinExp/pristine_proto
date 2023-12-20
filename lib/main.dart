import 'package:flutter/material.dart';

import 'paw_print/paw_print.dart';
import 'views/counter.view.dart';

void main() {
  PawPrint.init(name: "ECHO");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echo Proto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterView(),
    );
  }
}
