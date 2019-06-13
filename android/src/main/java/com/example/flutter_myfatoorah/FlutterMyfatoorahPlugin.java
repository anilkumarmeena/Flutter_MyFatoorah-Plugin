package com.example.flutter_myfatoorah;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import com.google.gson.Gson;
import com.myfatoorah.sdk.MFSDKListener;
import com.myfatoorah.sdk.model.invoice.InvoiceModel;
import com.myfatoorah.sdk.model.transaction.TransactionResponseModel;
import com.myfatoorah.sdk.utils.*;
import com.myfatoorah.sdk.views.MFSDK;



/** FlutterMyfatoorahPlugin */
public class FlutterMyfatoorahPlugin implements MethodCallHandler {
  /** Plugin registration. */
   static String BASE_URL = "https://apidemo.myfatoorah.com/";
   static String EMAIL = "apiaccount@myfatoorah.com" ;// Merchant Email
   static String PASSWORD = "api12345*";  // Merchant Password
    String TAG = "PAYMENT";
    String data ,can;

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_myfatoorah");
    channel.setMethodCallHandler(new FlutterMyfatoorahPlugin());
    MFSDK.INSTANCE.init(BASE_URL, EMAIL, PASSWORD);

  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {

    if (call.method.equals("payment")) {
      
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }
}
