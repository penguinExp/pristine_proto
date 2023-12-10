import 'store.dart';

class EchoGraph {
  late final Map<AEchoStore, Set<AEchoStore>> _graph;

  EchoGraph() : _graph = {};

  void createNode(AEchoStore store, Set<AEchoStore> dependencies) {
    _graph[store] = dependencies;
  }

  Set<AEchoStore>? getDependencies(AEchoStore store) {
    return _graph[store];
  }

  void deleteNode(AEchoStore store) {
    _graph.remove(store);
  }
}
