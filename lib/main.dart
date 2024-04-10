import 'package:flutter/material.dart';
import 'home.dart';
import 'echo/echo.dart';
// import 'paw/paw.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Paw.init(
    //   name: "ECHO",
    //   shouldIncludeSourceInfo: true,
    //   maxStackTraces: 3,
    //   shouldPrintLogs: true,
    //   shouldPrintName: true,
    // );

    Echo.init();

    return MaterialApp(
      title: 'Echo Proto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
