import 'package:flutter/material.dart';

abstract class PristineStore<T> {
  late T _state;

  T get state => _state;

  // ignore: unused_element
  void _assign(T value);

  void update(T Function(T) updateCallback);

  void dispose();
}

class Store<T> extends PristineStore<T> {
  late ValueNotifier<T> _valueNotifier;

  T Function(T)? depends;

  Store(T defaultValue, {this.depends}) {
    _state = defaultValue;
    _valueNotifier = ValueNotifier<T>(_state);
  }

  ValueNotifier<T> get stream => _valueNotifier;

  @override
  void _assign(T value) {
    if (depends != null) {
      _state = depends!(_state);
    } else {
      _state = value;
    }

    _valueNotifier.value = _state;
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
  }

  @override
  void update(T Function(T) updateCallback) {
    _assign(updateCallback(_state));
  }
}
