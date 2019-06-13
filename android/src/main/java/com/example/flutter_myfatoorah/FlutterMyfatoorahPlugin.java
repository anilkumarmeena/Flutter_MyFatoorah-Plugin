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
import android.util.Log;

/** FlutterMyfatoorahPlugin */
public class FlutterMyfatoorahPlugin implements MethodCallHandler, MFSDKListener {
  String BASE_URL = "https://apidemo.myfatoorah.com/";
    String EMAIL = "apiaccount@myfatoorah.com" ;// Merchant Email
    String PASSWORD = "api12345*";  // Merchant Password
    String TAG = "PAYMENT";
    String data ,can;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_myfatoorah");
    channel.setMethodCallHandler(new FlutterMyfatoorahPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
      Boolean lang =  true;
      pay(lang); 
    } else {
      result.notImplemented();
    }
  }

  private void pay(Boolean lang){
    InvoiceModel invoiceModel = new InvoiceModel(20.0, "Test", Country.KUWAIT, CurrencyISO.Kuwaiti_Dinar_KWD);
    if(lang){
      MFSDK.INSTANCE.createInvoice(this, "ar", invoiceModel,  PaymentMethod.KNET);
    }
    else{
      MFSDK.INSTANCE.createInvoice(this, "ar", invoiceModel,  PaymentMethod.KNET);
    }
  }

    @Override 
  public void onSuccess( TransactionResponseModel transactionResponseModel) { 
    data = new Gson().toJson(transactionResponseModel);
    String text = "Success\n\nResponse:\n\n" + data; 
    Log.d(TAG, text); 
  } 

  @Override 
  public void onFailed(int i,  String s) { 
    String text = "Failed: $statusCode\n\nError Message:\n\n$error";
    can =  "Failed: $statusCode Error Message: $error";
    Log.d(TAG, text); 
  } 

  @Override 
  public void onCanceled( String error) { 
    can = "canceled" ;
  Log.d(TAG, error); 
  }
}
