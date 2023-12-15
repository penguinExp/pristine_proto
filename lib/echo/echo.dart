import 'package:flutter/material.dart';

import 'controller.dart';
import 'graph.dart';
import 'store.dart';

/// 
/// class to manage controllers
/// 
class Echo {
  static Echo? _instance;

  Echo._();

  factory Echo() {
    _instance ??= Echo._();

    return _instance!;
  }

  final Map<Key, EchoController> _controllers = {};

  /// init the controller
  /// if the instance is already created, then it doesn't create a new one
  /// it returns the original one
  T put<T extends EchoController>(T Function() create) {
    final controller = create();

    final key = controller.key;

    if (_controllers.containsKey(key)) {
      return _controllers[key]! as T;
    }

    _controllers[key] = controller;

    controller.onInit();

    return controller;
  }

  /// calls the onDispose for the controller and
  /// deletes the controller instance
  void delete(EchoController controller) {
    final key = controller.key;

    final ctrl = _controllers[key];

    if (ctrl != null) {
      ctrl.onDispose();

      _controllers.remove(key);
    }
  }
}

///
/// class to manage all the stores and their
/// dependency graph
///
/// for internal use only
/// should not be exposed globally
///
class EchoStore {
  static EchoStore? _instance;

  EchoStore._();

  factory EchoStore() {
    _instance ??= EchoStore._();

    return _instance!;
  }

  // graph of the stores and their dependencies
  final EchoGraph _graph = EchoGraph();

  // create a root node in the graph for a specific store
  // to be executed when [store.init()] occurs
  void createRootNode(EchoStoreInterface root) {
    _graph.createRoot(root);
  }

  // delete a root node from the graph
  // to be executed when [store.dispose()] occurs
  void deleteRoot(EchoStoreInterface root) {
    _graph.deleteRoot(root);
  }

  // add a dependency for a root node
  void addDependency(EchoStoreInterface root, EchoStoreInterface node) {
    _graph.addNode(root, node);
  }

  // remove a dependency from root node
  void removeDependency(EchoStoreInterface root, EchoStoreInterface node) {
    _graph.removeNode(root, node);
  }

  // update all the dependencies of a particular store
  void updateStoreNodes(EchoStoreInterface root) {
    final dependencies = _graph.getNodes(root);

    if (dependencies == null) {
      // log the warning / error here
      return;
    }

    for (EchoStoreInterface element in dependencies) {
      element.autoUpdate();
    }
  }
}
