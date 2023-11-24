import 'dart:async';

abstract class _OneStateStore<T> {
  late T _state;

  late StreamController<T> _streamController;

  _OneStateStore() {
    _streamController = StreamController<T>.broadcast();
  }

  Stream<T> get stream => _streamController.stream;

  void set(T value) {
    _state = value;
    _streamController.add(_state);
  }

  void update();

  void updateWith(T Function(T) updateCallback);

  void dispose() {
    _streamController.close();
  }
}

class OneStore<T> extends _OneStateStore<T> {
  dynamic Function(dynamic)? _customUpdate;

  OneStore(
    T value, {
    T Function(T)? depends,
  }) {
    _state = value;

    if (depends != null) {
      _customUpdate = (p0) => depends(p0) as dynamic;
    }
  }

  @override
  void update() {
    if (_customUpdate != null) {
      final value = _customUpdate!(_state);
      set(value);
    }
  }

  @override
  void updateWith(T Function(T) updateCallback) {
    set(updateCallback(_state));
  }
}
