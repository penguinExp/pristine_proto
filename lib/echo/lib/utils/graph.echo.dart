import '../stores/core/interface.store.echo.dart';

class EchoGraph {
  final Map<EchoStoreInterface, Set<EchoStoreInterface>> _graph;

  EchoGraph() : _graph = {};

  Set<EchoStoreInterface>? getNodes(EchoStoreInterface root) {
    final nodes = _graph[root];

    if (nodes != null) {
      return nodes;
    }

    // log the errors here

    return null;
  }

  /// init the root node in the graph
  void createRoot(EchoStoreInterface root) {
    _graph[root] = {};
  }

  /// delete the root node from the graph
  void deleteRoot(EchoStoreInterface root) {
    _graph.remove(root);
  }

  /// add a node to the root store dependency set
  void addNode(EchoStoreInterface root, EchoStoreInterface node) {
    final currentNodes = _graph[root];

    if (currentNodes != null) {
      _graph[root]?.add(node);
    }

    // log the errors here with custom logger
  }

  void removeNode(EchoStoreInterface root, EchoStoreInterface node) {
    final currentNodes = _graph[root];

    if (currentNodes != null) {
      _graph[root]?.remove(node);
    }

    // log the errors here with custom logger
  }
}
