import 'dart:async';
import 'package:flutter/material.dart';

class StateManager<T> {
  late T _state;
  late StreamController<T> _streamController;

  StateManager(T initState) {
    _state = initState;
    _streamController = StreamController<T>.broadcast();
  }

  T get state => _state;

  Stream<T> get stream => _streamController.stream;

  void update(T newState) {
    _state = newState;
    _streamController.add(_state);
  }

  void dispose() {
    _streamController.close();
  }
}

class StateWidget extends StatelessWidget {
  final Widget Function(BuildContext, AsyncSnapshot<dynamic>) child;
  final StateManager stateManager;
  const StateWidget({Key? key, required this.child, required this.stateManager})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stateManager.stream,
      initialData: stateManager.state,
      builder: child,
    );
  }
}

// Variable which holds state
final stateManager = StateManager<int>(0);

class StreamProto extends StatelessWidget {
  const StreamProto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Kind of like OBX
            StateWidget(
              stateManager: stateManager,
              child: (context, snap) {
                return Text(
                  'Counter: ${snap.data}',
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Increment'),
              onPressed: () {
                // Updating the state
                final currentState = stateManager.state;
                
                stateManager.update(currentState + 1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
