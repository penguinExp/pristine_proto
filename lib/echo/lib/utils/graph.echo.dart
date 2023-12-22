import '../stores/core/interface.store.echo.dart';

class EchoGraph {
  final Map<EchoStoreInterface, Set<EchoStoreInterface>> _graph;

  EchoGraph() : _graph = {};

  /// fetch dependent nodes for the root store
  Set<EchoStoreInterface>? getNodes(EchoStoreInterface root) {
    final nodes = _graph[root];

    if (nodes != null) {
      return nodes;
    }

    return null;
  }

  /// init the root node in the graph
  void createRoot(EchoStoreInterface root) {
    _graph[root] = {};
  }

  /// delete the root node from the graph
  bool deleteRoot(EchoStoreInterface root) {
    return _graph.remove(root) == null ? false : true;
  }

  /// add a node to the root store dependency set
  bool addNode(EchoStoreInterface root, EchoStoreInterface node) {
    if (_graph[root] != null) {
      return _graph[root]!.add(node);
    }

    return false;
  }

  bool removeNode(EchoStoreInterface root, EchoStoreInterface node) {
    if (_graph[root] != null) {
      return _graph[root]!.remove(node);
    }

    return false;
  }
}
