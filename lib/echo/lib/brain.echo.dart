import '../../paw_print/paw_print.dart';
import 'controllers/manager.controller.echo.dart';
import 'stores/core/manager.store.echo.dart';

///
/// Centralised class to init all services
/// can not be invoked by user
///
class Echo {
  ///
  /// State if echo should print logs or not
  ///
  final bool printLogs;

  static Echo? _instance;

  Echo._({required this.printLogs});

  static Echo init({bool printLogs = true}) {
    _instance ??= Echo._(printLogs: printLogs);

    // init logger
    PawPrint.init(
      name: "echo",
      maxStackTraces: 3,
      shouldPrintName: true,
      shouldPrintLogs: printLogs,
    );

    // init service manager
    EchoService.init();

    // init store manager
    EchoStoreManager.init();

    return _instance!;
  }
}
