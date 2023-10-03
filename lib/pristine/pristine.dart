import 'controller.dart';

class Pristine {
  // Private static instance variable
  static Pristine? _instance;

  // Map to store controller instances
  final Map<PTypeKey, PristineController> _controllers = {};

  // Private constructor
  Pristine._();

  // Factory constructor to create or return the existing instance
  factory Pristine() {
    _instance ??= Pristine._();

    return _instance!;
  }

  // Function to create or retrieve a controller instance
  PristineControllerType put<PristineControllerType extends PristineController>(
      PristineControllerType Function() create) {
    final key = PTypeKey<PristineControllerType>();

    // Retrieve existing controller if it exists
    if (_controllers.containsKey(key)) {
      return _controllers[key]! as PristineControllerType;
    }

    // Create a new controller instance
    final controller = create();

    // Store the controller instance
    _controllers[key] = controller;

    // Call onInit function
    controller.onInit();

    return controller;
  }

  // Function to delete a controller instance
  void delete<PristineControllerType extends PristineController>() {
    final key = PTypeKey<PristineControllerType>();

    // Retrieve the controller instance if it exists
    final controller = _controllers[key];

    if (controller != null) {
      // Call onDispose function
      controller.onDispose();

      // Remove the controller instance from the map
      _controllers.remove(key);
    }
  }
}

// Helper class to represent type keys
class PTypeKey<T> {
  const PTypeKey();
}

// Extension method to simplify usage of type keys
extension PTypeKeyExtension<T> on T {
  PTypeKey<T> get key => const PTypeKey();
}
