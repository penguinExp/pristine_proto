import 'package:flutter/material.dart';
import 'package:pristine_proto/one_state/views/simple_counter.os.dart';

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
      home: const SimpleCounterViewOS(),
    );
  }
}
