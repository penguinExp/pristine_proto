import 'controller.dart';

import 'echo_graph.dart';
import 'store.dart';

final Echo echo = Echo();

class Echo {
  static Echo? _instance;

  Echo._();

  factory Echo() {
    _instance ??= Echo._();

    return _instance!;
  }

  final EchoGraph _graph = EchoGraph();

  final Map<EchoControllerTypeKey, EchoController> _controllers = {};

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

  PristineControllerType put<PristineControllerType extends EchoController>(
    PristineControllerType Function() create,
  ) {
    //
    final key = EchoControllerTypeKey<PristineControllerType>();

    // Retrieve existing controller if it exists
    if (_controllers.containsKey(key)) {
      return _controllers[key]! as PristineControllerType;
    }

    // Create a new controller instance
    final controller = create();

    // Store the controller instance
    _controllers[key] = controller;

    // Call onInit function
    controller.onInit();

    return controller;
  }

  // Function to delete a controller instance
  void delete<PristineControllerType extends EchoController>() {
    final key = EchoControllerTypeKey<PristineControllerType>();

    // Retrieve the controller instance if it exists
    final controller = _controllers[key];

    if (controller != null) {
      // Call onDispose function
      controller.onDispose();

      // Remove the controller instance from the map
      _controllers.remove(key);
    }
  }
}
