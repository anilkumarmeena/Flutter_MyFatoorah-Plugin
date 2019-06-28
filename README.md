# MyFatoorah Payment Gateway Plugin

A flutter plugin for integrating MyFatoorah payment gateway. Supports Android and iOS. 

### Installing
Add this in pubspec.yaml
```
  dependencies:
    flutter_myfatoorah: ^0.0.7
```
### iOS 9+ Specific
ios developers should add the following to their plist
```
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    <key>NSAllowsArbitraryLoadsForMedia</key>
    <true/>
    <key>NSAllowsArbitraryLoadsInWebContent</key>
    <true/>
</dict>
```

### Using
```
import 'package:flutter_myfatoorah/flutter_myfatoorah.dart';
```

```
startpayment() async {
    //Testing Credentials
    String credUrl = "https://apidemo.myfatoorah.com/";
    String credEmail = "apiaccount@myfatoorah.com";
    String credPass = "api12345*";
    int language = 0;
    String name = "anil meena";
    double price = 555.0;
    String paymentMethod = ".all";
    var response ;
    Map<dynamic, dynamic> map = {"cred_url":credUrl,
                                "cred_email":credEmail,
                                "cred_pass":credPass,
                                "language":language,
                                "name":name,
                                "price":price,
                                "payment_method":paymentMethod};
    try {
           response = await FlutterMyfatoorah.payment(map);
        } on PlatformException {
            print('error');
        }
}
```
See the ```example``` directory for a complete sample app.

### Responses :
```
Sucess Response:
    all data about payment done in json string format

Error Response:
    cancelled by user: {"Error":"Payment Cancelled"}
    
    Gateway Errors: {"Error":"ssl error","responseCode":"500"}
```



