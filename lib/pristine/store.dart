import 'package:flutter/material.dart';
import 'brain.dart';

abstract class PristineStore<T> {
  late T _state;

  T get state => _state;

  void assign(T value);

  void update(dynamic Function(dynamic) updateCallback);

  void dispose();
}

class Store<T> extends PristineStore<T> {
  late ValueNotifier<T> _valueNotifier;

  dynamic Function(dynamic)? depends;

  Set<Store<dynamic>>? _dependencies;

  Store(
    T defaultValue, {
    T Function(T)? d,
    Set<Store<T>>? dependencies,
  }) {
    _state = defaultValue;
    _dependencies = dependencies;
    _valueNotifier = ValueNotifier<T>(_state);

    if (d != null) {
      depends = (p0) => d(p0) as dynamic;
    }

    if (_dependencies != null) {
      PristineBrain().addStore(this, _dependencies!);
    }
  }

  ValueNotifier<T> get stream => _valueNotifier;

  @override
  void assign(T value) {
    if (depends != null) {
      _state = depends!(_state);
    } else {
      _state = value;
    }

    _valueNotifier.value = _state;

    PristineBrain().updateStore(this);
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
  }

  @override
  void update(dynamic Function(dynamic) updateCallback) {
    assign(updateCallback(_state) as T);
  }
}
