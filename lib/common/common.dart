import 'package:flutter/foundation.dart';

class Constant{
  static const int status_success = 0;
}

class AppConfig {
  static const String appName = "flutter_app";
  static const String packageBase = "flutter_app";
  static const String version = '1.0.0+1';
  static const bool isDebug = kDebugMode;
}

class LoadStatus {
  static const int fail = -1;
  static const int loading = 0;
  static const int success = 1;
  static const int empty = 2;
}