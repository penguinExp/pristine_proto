import 'echo_graph.dart';
import 'store.dart';

class Echo {
  static Echo? _instance;

  Echo._();

  factory Echo() {
    _instance ??= Echo._();

    return _instance!;
  }

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
