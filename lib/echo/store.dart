import 'package:flutter/material.dart';

import 'echo.dart';

abstract class AEchoStore<T> {
  late T _state;

  T get state => _state;

  T Function(T value)? defaultCallback;

  Set<AEchoStore>? defaultDependencies;

  AEchoStore<T> set(T value);

  AEchoStore<T> update(T Function(T value)? callback);

  void dispose();
}

class ValueStore<T> extends AEchoStore<T> {
  late ValueNotifier<T> _stateNotifier;

  final Echo _echo = Echo();

  ValueStore(
    T value, {
    T Function(T value)? callback,
    Set<AEchoStore>? dependencies,
  }) {
    defaultCallback = callback;
    defaultDependencies = dependencies;
    _state = value;
    _stateNotifier = ValueNotifier(_state);

    _echo.createStoreNode(this, dependencies ?? {});
  }

  ValueNotifier get notifier => _stateNotifier;

  @override
  void dispose() {
    _stateNotifier.dispose();

    _echo.removeStoreNode(this);
  }

  @override
  ValueStore<T> set(T value) {
    _state = value;
    _stateNotifier.value = _state;

    _echo.updateDependencies(this);

    return this;
  }

  @override
  ValueStore<T> update(T Function(T value)? callback) {
    if (defaultCallback != null) {
      _state = defaultCallback!(_state);
    } else if (callback != null) {
      _state = callback(_state);
    } else {
      // log here that state is not being updated!
      return this;
    }

    _stateNotifier.value = _state;

    _echo.updateDependencies(this);

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
  ObjectStore<T> update(T Function(T value)? callback) {
    _state = callback!(_state);

    _stateNotifier.value = _state;

    _stateNotifier.notifyListeners();

    return this;
  }
}
