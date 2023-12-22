import 'package:flutter/material.dart';

import '../../../paw/paw.dart';
import 'interface.controller.echo.dart';

///
/// class to manage controllers
///
mixin EchoControllerManagerMixin {
  // private logger instance
  final Paw _paw = Paw();

  final Map<Key, EchoController> _controllers = {};

  /// init the controller
  /// if the instance is already created, then it doesn't create a new one
  /// it returns the original one
  T put<T extends EchoController>(T Function() create) {
    final controller = create();

    final key = controller.key;

    if (_controllers.containsKey(key)) {
      _paw.info("Fetched already created instance of $controller");
      return _controllers[key] as T;
    }

    _controllers[key] = controller;

    controller.onInit();

    _paw.info("Created instance of $controller:${key.toString()}");

    return controller;
  }

  /// calls the onDispose for the controller and
  /// deletes the controller instance
  void delete(EchoController controller) {
    final key = controller.key;

    final ctrl = _controllers[key];

    if (ctrl != null) {
      ctrl.onDispose();

      _controllers.remove(key);

      _paw.info("Instance of $controller:${key.toString()} has been deleted");

      return;
    }

    // log an error if controller not found or already been deleted
    _paw.error(
      "Error occurred while deleting the controller",
      error: Exception("Instance of $controller:${key.toString()} not found"),
    );
  }
}
