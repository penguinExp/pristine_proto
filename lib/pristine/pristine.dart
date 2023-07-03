import 'store.dart';
import 'dart:math';

class Pristine {
  final Map<Store, Set<Store>> _graph = {};

  void update() {
    final st = ValueStore(0);
    final store = _graph.containsKey(st) ? _graph[st]?.first : null;

    if (store != null) {
      store.update((p0) => p0);
    }
  }

  Store createStore({required Store store, Set<Store>? dependencies}) {
    if (store is ValueStore) {}

    return store;
  }

  void test() {
    // final a = createStore(ValueStore<int>(0));

    // final b = createStore(ValueStore<String>('0'), );

    final v = ValueStore<int>(0);

    final a = createStore(
      store: ValueStore<String>('0'),
      dependencies: <Store>{v},
    );

    a.assign(0);
  }
}

String _generateRandomId({int length = 10}) {
  final random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';

  String id = '';

  for (int i = 0; i < length; i++) {
    final randomIndex = random.nextInt(chars.length);
    id += chars[randomIndex];
  }

  return id;
}

abstract class PristineState {
  bool get isGlobal => false;

  String get _key => _generateRandomId();

  String get key {
    return _key;
  }
}
