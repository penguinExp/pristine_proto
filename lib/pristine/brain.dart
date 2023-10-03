import 'store.dart';

// Singleton class PristineBrain
class PristineBrain {
  // Private static instance variable
  static PristineBrain? _instance;

  // Private constructor
  PristineBrain._();

  // Factory constructor to create or return the existing instance
  factory PristineBrain() {
    _instance ??= PristineBrain._();

    return _instance!;
  }

  final Map<Store, Set<Store>> _graph = {};

  void addStore(Store store, Set<Store> dependencies) {
    _graph[store] = dependencies;
  }

  void updateStore(Store store) {
    final dependencies = _graph[store];

    if (dependencies != null) {
      for (var element in dependencies) {
        element.update(element.depends! as dynamic);
      }
    }
  }

  void removeStore(PristineStore store) {
    _graph.remove(store);
  }
}
