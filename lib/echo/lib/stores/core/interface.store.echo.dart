import 'manager.store.echo.dart';

abstract class EchoStoreInterface<T> {
  // instance of store manager
  final EchoStoreManager _echoStore = EchoStoreManager();

  T _state;

  T Function(T value)? _updateCallback;

  EchoStoreInterface(
    this._state, {
    T Function(T value)? updateCallback,
  }) {
    _updateCallback = updateCallback;

    // creating a root node for the state graph
    _echoStore.createRootNode(this);
  }

  T get state => _state;

  set state(T newState) {
    _state = newState;
    _echoStore.updateStoreNodes(this);
  }

  void set(T newState);

  void update(T Function(T value) callback);

  void dispose() {
    _echoStore.deleteRoot(this);
  }

  void autoUpdate([T Function(T value)? newCallback]) {
    _updateCallback = newCallback ?? _updateCallback;
    if (_updateCallback != null) {
      state = _updateCallback!(_state);
    }
  }

  void addDependency(EchoStoreInterface store) {
    _echoStore.addDependency(this, store);
  }

  void removeDependency(EchoStoreInterface store) {
    _echoStore.removeDependency(this, store);
  }

  void setUpdateCallback(T Function(T value) callback) {
    _updateCallback = callback;
  }
}
