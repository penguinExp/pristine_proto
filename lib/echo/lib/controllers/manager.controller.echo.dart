import 'package:flutter/material.dart';

import '../../../paw_print/paw_print.dart';
import 'interface.controller.echo.dart';

///
/// class to manage controllers
///
class EchoService {
  EchoService._();

  // private logger instance
  static final PawPrint _paw = PawPrint();

  static EchoService? _instance;

  factory EchoService() {
    if (_instance == null) {
      throw Exception(
        "`Echo` is not yet initialised, initialise it with `Echo.init()`",
      );
    }

    return _instance!;
  }

  static EchoService init() {
    _instance ??= EchoService._();

    _paw.info("Instance of _EchoService_ has been created");

    return _instance!;
  }

  final Map<Key, EchoController> _controllers = {};

  /// init the controller
  /// if the instance is already created, then it doesn't create a new one
  /// it returns the original one
  T put<T extends EchoController>(T Function() create) {
    final controller = create();

    final key = controller.key;

    if (_controllers.containsKey(key)) {
      return _controllers[key]! as T;
    }

    _controllers[key] = controller;

    controller.onInit();

    _paw.info("Instance of $controller has been instantiated");

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

      _paw.info("Instance of $controller has been deleted");
    }

    _paw.warn("Instance of $controller already been deleted");
  }
}
