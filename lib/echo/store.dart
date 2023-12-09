import 'package:flutter/material.dart';

abstract class AEchoStore<T> {
  late T _state;

  T get state => _state;

  AEchoStore<T> set(T value);

  AEchoStore<T> update(T Function(T value) callback);

  void dispose();
}

class ValueStore<T> extends AEchoStore<T> {
  late ValueNotifier<T> _stateNotifier;

  ValueStore(T value) {
    _state = value;
    _stateNotifier = ValueNotifier(_state);
  }

  ValueNotifier get notifier => _stateNotifier;

  @override
  void dispose() {
    _stateNotifier.dispose();
  }

  @override
  ValueStore<T> set(T value) {
    _state = value;
    _stateNotifier.value = _state;

    return this;
  }

  @override
  ValueStore<T> update(T Function(T value) callback) {
    _state = callback(_state);

    _stateNotifier.value = _state;

    return this;
  }
}

class ObjectStore<T> extends AEchoStore<T> with ChangeNotifier {
  late ValueNotifier<T> _stateNotifier;

  ObjectStore(T value) {
    _state = value;
    _stateNotifier = ValueNotifier(_state);
  }

  ValueNotifier get notifier => _stateNotifier;

  @override
  void dispose() {
    _stateNotifier.dispose();
    super.dispose();
  }

  @override
  ObjectStore<T> set(T value) {
    _state = value;

    _stateNotifier.value = _state;

    _stateNotifier.notifyListeners();

    return this;
  }

  @override
  ObjectStore<T> update(T Function(T value) callback) {
    _state = callback(_state);

    _stateNotifier.value = _state;

    _stateNotifier.notifyListeners();

    return this;
  }
}
