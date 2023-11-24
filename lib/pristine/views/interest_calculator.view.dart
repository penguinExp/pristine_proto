import 'package:flutter/material.dart';
import 'package:pristine_proto/pristine/controller.dart';

class InterestCalculatorView extends StatefulWidget {
  const InterestCalculatorView({super.key});

  @override
  State<InterestCalculatorView> createState() => _InterestCalculatorViewState();
}

class _InterestCalculatorViewState extends State<InterestCalculatorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interest Calculator"),
        centerTitle: true,
      ),
      body: Column(children: []),
    );
  }
}

class InterestCalculatorController extends PristineController {}
