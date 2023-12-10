import 'package:flutter/material.dart';

// import 'views/list_api.view.dart';
// import 'views/list.view.dart';
import 'views/slider.view.dart';
// import 'views/counter.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pristine Proto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SliderView(),
    );
  }
}
