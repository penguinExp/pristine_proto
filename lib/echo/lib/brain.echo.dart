import '../../paw/paw.dart';
import 'controllers/manager.controller.echo.dart';
import 'stores/core/manager.store.echo.dart';

///
/// Centralised class to init all services
/// can not be invoked by user
///
class Echo with EchoControllerManagerMixin {
  ///
  /// State if echo should print logs or not
  ///
  final bool printLogs;

  static Echo? _instance;

  Echo._({required this.printLogs});

  factory Echo() {
    if (_instance == null) {
      throw Exception(
        "`Echo` is not yet initialised, initialise it with `Echo.init()`",
      );
    }

    return _instance!;
  }

  static Echo init({bool printLogs = true}) {
    // create a new instance if not already created
    if (_instance == null) {
      // Create instance of Echo
      _instance = Echo._(printLogs: printLogs);

      // init logger
      Paw.init(
        name: "echo",
        maxStackTraces: 3,
        shouldPrintName: true,
        shouldPrintLogs: printLogs,
      );

      // init store manager
      EchoStoreManager.init();
    }

    return _instance!;
  }
}
