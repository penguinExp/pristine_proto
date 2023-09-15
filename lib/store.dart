import 'package:flutter/cupertino.dart';

abstract class PristineStore<T> {
  late T _state;

  T get state => _state;

  void assign(T value);

  void update(T Function(T) updateCallback);

  void dispose();
}

class ValueStore<T> extends PristineStore<T> {
  late ValueNotifier<T> _valueNotifier;

  T Function(T)? depends;

  ValueStore(T defaultValue, {this.depends}) {
    _state = defaultValue;
    _valueNotifier = ValueNotifier<T>(_state);
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
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
  }

  @override
  void update(T Function(T) updateCallback) {
    assign(updateCallback(_state));
  }
}
