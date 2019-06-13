import 'dart:async';

import 'package:flutter/services.dart';

class FlutterMyfatoorah {
  static const MethodChannel _channel =
      const MethodChannel('flutter_myfatoorah');

  static Future<String> get payment async {
    final String version = await _channel.invokeMethod('payment');
    return version;
  }
}
