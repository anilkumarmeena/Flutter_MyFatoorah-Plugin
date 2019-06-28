import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_myfatoorah/flutter_myfatoorah.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = 'Tap Pay';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startpayment() async {
    //test credentials
    String credUrl = "https://apidemo.myfatoorah.com/";
    String credEmail = "apiaccount@myfatoorah.com";
    String credPass = "api12345*";
    int language = 0;
    String name = "anil meena";
    double price = 555.0;
    String paymentMethod = ".all";
    String data;
    Map<dynamic, dynamic> map = {"cred_url":credUrl,
                              "cred_email":credEmail,
                              "cred_pass":credPass,
                              "language":language,
                              "name":name,
                              "price":price,
                              "payment_method":paymentMethod};
    try {
          data = await FlutterMyfatoorah.payment(map);
        } on PlatformException {
          data = 'Failed';
        }
    setState(() {
      result = data;
      print(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin MyFatoorah'),
        ),
        body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.grey,
                  child: Text("Pay"), 
                  onPressed: (){
                    startpayment();
                  },
                ),
                SizedBox(),
                Text(result),
              ],
            ),
        ),
        ),
    );
  }
}
