import 'dart:async';

import 'package:flutter/services.dart';

class FlutterMyfatoorah {
  static const MethodChannel _channel =
      const MethodChannel('flutter_myfatoorah');

  static Future<String>  payment(Map<dynamic, dynamic> map) async {
    final String data = await _channel.invokeMethod('payment',map);
    return data;
  }
}
