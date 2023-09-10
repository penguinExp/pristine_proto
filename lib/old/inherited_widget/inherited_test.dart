import 'package:flutter/material.dart';

class AppState {
  int counter = 0;
}

class AppStateProvider extends InheritedWidget {
  final AppState state;

  const AppStateProvider(
      {super.key, required this.state, required Widget child})
      : super(child: child);

  static AppStateProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
  }

  @override
  bool updateShouldNotify(AppStateProvider oldWidget) {
    return oldWidget.state.counter != state.counter;
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context)!.state;

    return Text('Counter: ${appState.counter}');
  }
}

class IncrementButton extends StatelessWidget {
  const IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context)!.state;

    return ElevatedButton(
      onPressed: () {
        appState.counter++;
      },
      child: const Text('Increment'),
    );
  }
}

class MyApp extends StatelessWidget {
  final AppState appState = AppState();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateProvider(
      state: appState,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('State Manager Example')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CounterWidget(),
              IncrementButton(),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
