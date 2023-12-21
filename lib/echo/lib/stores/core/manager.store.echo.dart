import '../../../../paw_print/paw_print.dart';

import '../../utils/graph.echo.dart';
import 'interface.store.echo.dart';

/// A singleton class for managing interdependencies between stores.
///
/// It uses a graph structure to manage and update the dependencies.
class EchoStoreManager {
  static final _paw = PawPrint();

  static EchoStoreManager? _instance;

  EchoStoreManager._();

  factory EchoStoreManager() {
    if (_instance == null) {
      throw Exception(
        "`Echo` is not yet initialised, initialise it with `Echo.init()`",
      );
    }

    return _instance!;
  }

  static EchoStoreManager init() {
    _instance ??= EchoStoreManager._();

    _paw.info("Instance of _EchoStoreManager_ has been created");

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
    _graph.addNode(root, node);

    _paw.info("Added dependency to $root");
  }

  /// Removes a dependency from a root node.
  void removeDependency(EchoStoreInterface root, EchoStoreInterface node) {
    _graph.removeNode(root, node);

    _paw.info("Removed dependency from $root");
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

    _paw.info("Dependent stores are updated for $root");
  }
}
