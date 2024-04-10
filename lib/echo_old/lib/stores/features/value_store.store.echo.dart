import 'package:flutter/material.dart';

import '../core/interface.store.echo.dart';
// import '../../../../paw/paw.dart';

///
/// Store to hold and update single object states
///
class ValueStore<T> extends EchoStoreInterface<T> with ChangeNotifier {
  // instance of logger
  // final _paw = Paw();

  late final ValueNotifier<T> _valueNotifier;

  ValueStore(T state, {T Function(T value)? updateCallback})
      : super(state, updateCallback: updateCallback) {
    _valueNotifier = ValueNotifier<T>(super.state);

    // _paw.info("Created ${toString()} - $hashCode");
  }

  ValueNotifier<T> get listener => _valueNotifier;

  @override
  set state(T newState) {
    super.state = newState;

    _valueNotifier.value = super.state;

    // Check if T is not int, double, String or bool
    if (!(newState is int ||
        newState is double ||
        newState is String ||
        newState is bool)) {
      // notify only if [T] is object, map or list, etc.
      _valueNotifier.notifyListeners();
    }
  }

  @override
  void dispose() {
    _valueNotifier.dispose();

    super.dispose();

    // _paw.info("Disposed ${toString()} - $hashCode");
  }

  @override
  void set(T newState) => state = newState;

  @override
  void update(T Function(T value) callback) => state = callback(super.state);

  @override
  String toString() {
    return "ValueStore<$T>";
  }
}
