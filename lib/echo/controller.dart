abstract class EchoController {
  void onInit() {}

  void onDispose() {}
}

class EchoControllerTypeKey<T> {
  const EchoControllerTypeKey();
}

extension EchoControllerTypeKeyExtension<T> on T {
  EchoControllerTypeKey<T> get key => const EchoControllerTypeKey();
}
