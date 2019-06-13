import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_myfatoorah/flutter_myfatoorah.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_myfatoorah');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterMyfatoorah.payment, '42');
  });
}
