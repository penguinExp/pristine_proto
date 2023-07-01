import 'dart:async';

import 'package:flutter/material.dart';

abstract class Store<T> {
  late T _state;

  T get state => _state;

  void assign(T value);

  void update(T Function(T) updateCallback);

  void dispose();
}

class ValueStore<T> extends Store<T> {
  late ValueNotifier<T> _valueNotifier;

  T Function(T)? depends;

  ValueNotifier<T> get stream => _valueNotifier;

  ValueStore(T defaultValue, {this.depends}) {
    _state = defaultValue;
    _valueNotifier = ValueNotifier<T>(_state);
  }

  @override
  void assign(T? value) {
    if (depends != null) {
      _state = depends!(_state);
    } else {
      _state = value ?? _state;
    }

    _valueNotifier.value = _state;
  }

  @override
  void update(T Function(T) updateCallback) {
    assign(updateCallback(_state));
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
  }
}

class StreamStore<T> extends Store<T> {
  late StreamController<T> _streamController;

  Stream<T> get stream => _streamController.stream;

  StreamStore(T defaultValue) {
    _state = defaultValue;
    _streamController = StreamController<T>.broadcast();
    assign(_state); // setting the initial state
  }

  @override
  void assign(T value) {
    _state = value;
    _streamController.add(_state);
  }

  @override
  void update(T Function(T) updateCallback) {
    assign(updateCallback(_state));
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
