import 'package:flutter/material.dart';

abstract class _OneStateStore<T> {
  late T _state;

  // update the value of the state
  void set(T value);

  // to dispose off the store
  void dispose();
}

class OneStore<T> extends _OneStateStore<T> {
  late ValueNotifier<T> _valueNotifier;

  OneStore(T value) {
    _state = value;
    _valueNotifier = ValueNotifier<T>(_state);
  }

  ValueNotifier<T> get state => _valueNotifier;

  @override
  void dispose() {
    _valueNotifier.dispose();
  }

  @override
  void set(T value) {
    _state = value;
    _valueNotifier.value = _state;
  }

  // Updated update method to accept a callback
  void update(void Function(T) updateCallback) {
    updateCallback(_state);
    set(_state);
  }
}
