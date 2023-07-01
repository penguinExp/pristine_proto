import 'package:pristine_proto/pristine/store.dart';

class Pristine {
  final Map<Store, Set<Store>> _graph = {};

  void update() {
    final st = ValueStore(0);
    final store = _graph.containsKey(st) ? _graph[st]?.first : null;

    if (store != null) {
      store.update((p0) => p0);
    }
  }
}
