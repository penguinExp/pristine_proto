import 'package:flutter/material.dart';

abstract class EchoController {
  final GlobalKey key;

  EchoController() : key = GlobalKey();

  void onInit() {}

  void onDispose() {}
}
