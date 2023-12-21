import 'package:flutter/material.dart';

import '../core/interface.store.echo.dart';
import '../../../../paw_print/paw_print.dart';

///
/// Store to hold and update single object states
///
class ValueStore<T> extends EchoStoreInterface<T> {
  // instance of logger
  final _paw = PawPrint();

  late final ValueNotifier<T> _valueNotifier;

  ValueStore(T state, {T Function(T value)? updateCallback})
      : super(state, updateCallback: updateCallback) {
    _valueNotifier = ValueNotifier<T>(super.state);

    _paw.info("Created instance of $this");
  }

  ValueNotifier<T> get listener => _valueNotifier;

  @override
  set state(T newState) {
    super.state = newState;

    _valueNotifier.value = super.state;
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();

    _paw.info("Disposed instance of $this");
  }

  @override
  void set(T newState) => state = newState;

  @override
  void update(T Function(T value) callback) => state = callback(super.state);
}
