import 'dart:async';

import 'package:flutter/material.dart';

import 'echo.dart';

abstract class EchoStoreInterface<T> {
  final EchoStore _echoStore = EchoStore();

  /// state, cached for faster use
  T state;

  /// a function to set the update logic
  /// to update the store automatically
  /// may change in future by the user, i.e. not a _final_
  T Function(T value)? updateCallback;

  EchoStoreInterface(this.state, {this.updateCallback}) {
    _echoStore.createRootNode(this);
  }

  /// assign new value to the store
  void set(T newState);

  /// create a update callback to update the state
  void update(T Function(T value) callback);

  /// disposes the root node from the graph
  void dispose() {
    _echoStore.deleteRoot(this);
  }

  /// to update the state using [updateCallback]
  /// receive the auto update function if already not being set
  /// TODO: need to ditach the update callback _update_ from this function
  void autoUpdate([T Function(T value)? newCallback]);

  /// add dependency to the current store
  /// the dependency may of any type, so do not add [T] to the interface
  void addDependency(EchoStoreInterface store) {
    _echoStore.addDependency(this, store);
    // log if dependency was not added
  }

  /// remove the dependency from the current store
  /// the dependency may of any type, so do not add [T] to the interface
  void removeDependency(EchoStoreInterface store) {
    _echoStore.removeDependency(this, store);
    // log if the dependency was not removed
  }
}

///
/// Store to hold and update single object states
///
class ValueStore<T> extends EchoStoreInterface<T> {
  late final ValueNotifier<T> _valueNotifier;

  ValueStore(super.state, {super.updateCallback}) {
    _valueNotifier = ValueNotifier(state);
  }

  /// to be used by value builder to listen to updates
  /// for internal use only
  ValueNotifier<T> get listener => _valueNotifier;

  @override
  void dispose() {
    _valueNotifier.dispose();

    super.dispose();
  }

  /// update the state with the newState
  void _setState(T newState) {
    state = newState;

    _valueNotifier.value = state;

    _echoStore.updateStoreNodes(this);
  }

  @override
  void set(T newState) {
    _setState(newState);
  }

  @override
  void update(T Function(T value) callback) {
    final newState = callback(state);
    _setState(newState);
  }

  @override
  void autoUpdate([T Function(T value)? newCallback]) {
    if (newCallback != null) {
      updateCallback = newCallback;
    }

    if (updateCallback != null) {
      final newState = updateCallback!(state);

      _setState(newState);
    }
  }
}

///
/// Store to hold and update complex object states
///
class StreamStore<T> extends EchoStoreInterface<T> {
  late final StreamController<T> _streamController;

  StreamStore(super.state, {super.updateCallback}) {
    _streamController = StreamController<T>.broadcast();

    _streamController.add(state);
  }

  /// to be used by stream builder to listen to updates
  /// for internal use only
  Stream<T> get listener => _streamController.stream;

  /// update the state with the newState
  void _setState(T newState) {
    state = newState;

    _streamController.add(state);
  }

  @override
  void autoUpdate([T Function(T value)? newCallback]) {
    if (newCallback != null) {
      updateCallback = newCallback;
    }

    if (updateCallback != null) {
      final newState = updateCallback!(state);
      _setState(newState);
    }
  }

  @override
  void dispose() {
    _streamController.close();

    super.dispose();
  }

  @override
  void set(T newState) {
    _setState(newState);
  }

  @override
  void update(T Function(T value) callback) {
    final newState = callback(state);
    _setState(newState);
  }
}
