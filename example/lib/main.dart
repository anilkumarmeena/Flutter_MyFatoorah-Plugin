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
  String platformVersion = 'Tap Pay';

  @override
  void initState() {
    super.initState();
  }

  Future<void> initPlatformState() async {
    //test credentials
    String credUrl = "https://apidemo.myfatoorah.com/";
    String credEmail = "apiaccount@myfatoorah.com";
    String credPass = "api12345*";
    bool language = false;
    String name = "anil meena";
    double price = 555.0;
    String data;
    Map<dynamic, dynamic> map = {"cred_url":credUrl,
                              "cred_email":credEmail,
                              "cred_pass":credPass,
                              "language":language,
                              "name":name,
                              "price":price,
                              "payment_method":"kn"};
    try {
          data = await FlutterMyfatoorah.payment(map);
        } on PlatformException {
          data = 'Failed';
        }
    setState(() {
      platformVersion = data;
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
                    initPlatformState();
                  },
                ),
                SizedBox(),
                Text(platformVersion),
              ],
            ),
        ),
        ),
    );
  }
}
