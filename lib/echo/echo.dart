import 'package:flutter/material.dart';

import 'controller.dart';
import 'echo_graph.dart';
import 'store.dart';

final Echo echo = Echo();

class Echo with EchoControllerMixin, EchoStoreMixin {
  static Echo? _instance;

  Echo._();

  factory Echo() {
    _instance ??= Echo._();

    return _instance!;
  }
}

mixin EchoStoreMixin {
  final EchoGraph _graph = EchoGraph();

  void createStoreNode(AEchoStore store, Set<AEchoStore> dependencies) {
    _graph.createNode(store, dependencies);
  }

  void removeStoreNode(AEchoStore store) {
    _graph.deleteNode(store);
  }

  void updateDependencies(AEchoStore store) {
    final dependencies = _graph.getDependencies(store);

    if (dependencies == null) {
      return;
    }

    for (var element in dependencies) {
      element.update(null);
    }
  }
}

mixin EchoControllerMixin {
  final Map<Key, EchoController> _controllers = {};

  T put<T extends EchoController>(
    T Function() create,
  ) {
    final controller = create();

    final key = controller.key;

    if (_controllers.containsKey(key)) {
      return _controllers[key]! as T;
    }

    _controllers[key] = controller;

    controller.onInit();

    return controller;
  }

  void delete(EchoController controller) {
    final key = controller.key;

    final ctrl = _controllers[key];

    if (ctrl != null) {
      ctrl.onDispose();

      _controllers.remove(key);
    }
  }
}
