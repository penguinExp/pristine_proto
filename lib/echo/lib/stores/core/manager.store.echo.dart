// import '../../../../paw/paw.dart';

import '../../utils/graph.echo.dart';
import 'interface.store.echo.dart';

/// A singleton class for managing interdependencies between stores.
///
/// It uses a graph structure to manage and update the dependencies.
class EchoStoreManager {
  // final _paw = Paw();

  static EchoStoreManager? _instance;

  EchoStoreManager._();

  factory EchoStoreManager() {
    // if user has not created an instance of echo, then throw an error
    // to tell to initialise the [echo] first
    if (_instance == null) {
      throw Exception(
        "`Echo` is not yet initialised, initialise it with `Echo.init()`",
      );
    }

    return _instance!;
  }

  static EchoStoreManager init() {
    _instance ??= EchoStoreManager._();

    return _instance!;
  }

  final EchoGraph _graph = EchoGraph();

  /// Creates a root node in the graph for a specific store.
  /// This should be called when a store is initialized.
  void createRootNode(EchoStoreInterface root) {
    _graph.createRoot(root);
  }

  /// Deletes a root node from the graph.
  /// This should be called when a store is disposed.
  void deleteRoot(EchoStoreInterface root) {
    _graph.deleteRoot(root);
  }

  /// Adds a dependency for a root node.
  void addDependency(EchoStoreInterface root, EchoStoreInterface node) {
    if (_graph.addNode(root, node)) {
      // _paw.info(
      //   "Created dependency of ${node.toString()} ---> ${root.toString()}",
      // );
      return;
    }

    // _paw.error(
    //   "Unable to create dependency of ${node.toString()} ---> ${root.toString()}",
    //   error: "Either dependency already created or root node does not exists",
    // );
  }

  /// Removes a dependency from a root node.
  void removeDependency(EchoStoreInterface root, EchoStoreInterface node) {
    if (_graph.removeNode(root, node)) {
      // _paw.info(
      //   "Removed dependency of ${node.toString()} --x-> ${root.toString()}",
      // );
      return;
    }

    // _paw.error(
    //   "Unable to remove dependency from ${root.toString()}",
    //   error:
    //       "No dependency found between ${node.toString()} --> ${root.toString()}",
    // );
  }

  /// Updates all the dependencies of a particular store.
  void updateStoreNodes(EchoStoreInterface root) {
    final dependencies = _graph.getNodes(root);

    if (dependencies == null) {
      return;
    }

    for (final element in dependencies) {
      element.autoUpdate();
    }
  }
}
