import 'package:flutter/material.dart';
import 'home.dart';
import 'echo/echo.dart';
import 'paw_print/paw_print.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    PawPrint.init(
      name: "ECHO",
      shouldIncludeSourceInfo: false,
      maxStackTraces: 3,
      shouldPrintLogs: true,
      shouldPrintName: true,
    );

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

///
/// Logging guidelines for [echo], 
/// 
/// - Stores are initiated and disposed
/// - Controllers are initiated and disposed
/// - Instance of classes and services has been created
/// - errors and warnings
///

///
/// Bugs so far,
/// 
/// - [echo] controller is getting deleted twice
/// - [echo] EchoService and EchoStoreManager are getting instantiated again 
///   and again 
/// 

///
/// Features to add,
/// 
/// - [Paw] make the name/title color customizable
/// 
