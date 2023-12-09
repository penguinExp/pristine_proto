import 'package:flutter/material.dart';

abstract class AOneStore<T> {
  late T _state;

  T get state;

  // update the value of the state
  void set(T value);

  void update(T Function(T value) updateCallback);

  // to dispose off the store
  void dispose();
}

class ValueStore<T> extends AOneStore<T> with ChangeNotifier {
  late ValueNotifier<T> _valueNotifier;

  ValueStore(T value) {
    _state = value;
    _valueNotifier = ValueNotifier(_state);
  }

  ValueNotifier<T> get notifier => _valueNotifier;

  @override
  T get state => _state;

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  void set(T value) {
    _state = value;

    _valueNotifier.value = _state;
  }

  @override
  void update(T Function(T value) updateCallback) {
    _state = updateCallback(_state);

    _valueNotifier.value = _state;

    _valueNotifier.notifyListeners();
  }
}
