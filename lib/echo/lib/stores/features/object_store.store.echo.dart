import 'dart:async';

import '../../../../paw/paw.dart';
import '../core/interface.store.echo.dart';

///
/// Store to hold and update complex object states
///
class ObjectStore<T> extends EchoStoreInterface<T> {
  // instance of logger
  final _paw = Paw();

  late final StreamController<T> _streamController;

  ObjectStore(T state, {T Function(T value)? updateCallback})
      : super(state, updateCallback: updateCallback) {
    _streamController = StreamController<T>.broadcast();
    _streamController.add(super.state);

    _paw.info("Created ${toString()} - $hashCode");
  }

  Stream<T> get listener => _streamController.stream;

  @override
  set state(T newState) {
    super.state = newState;
    _streamController.add(super.state);
  }

  @override
  void dispose() {
    _streamController.close();

    super.dispose();

    _paw.info("Disposed ${toString()} - $hashCode");
  }

  @override
  void set(T newState) => state = newState;

  @override
  void update(T Function(T value) callback) => state = callback(super.state);

  @override
  String toString() {
    return "ObjectStore<$T>";
  }
}
