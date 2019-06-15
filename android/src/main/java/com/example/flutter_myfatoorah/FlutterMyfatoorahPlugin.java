package com.example.flutter_myfatoorah;

import android.app.Activity;
import android.content.Intent;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterMyfatoorahPlugin */
public class FlutterMyfatoorahPlugin implements MethodCallHandler , PluginRegistry.ActivityResultListener {
  private  final MethodChannel channel;
  private Activity activity;
  private Result pendingResult;
  private Map<String, Object> arguments;

  public FlutterMyfatoorahPlugin(Activity activity, MethodChannel channel) {
    this.activity = activity;
    this.channel = channel;
    this.channel.setMethodCallHandler(this);
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_myfatoorah");
    FlutterMyfatoorahPlugin obj = new FlutterMyfatoorahPlugin(registrar.activity(),channel);
    channel.setMethodCallHandler(obj);
    registrar.addActivityResultListener(obj);

  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    pendingResult = result;
    if (call.method.equals("payment")) {
      arguments = (Map<String, Object>) call.arguments;
      Intent intent = new Intent(activity,PaymentActivity.class);
      intent.putExtra(PaymentActivity.Ex_BASE_URL,(String) arguments.get("cred_url"));
      intent.putExtra(PaymentActivity.Ex_EMAIL,(String) arguments.get("cred_email"));
      intent.putExtra(PaymentActivity.Ex_PASSWORD,(String) arguments.get("cred_pass"));
      intent.putExtra(PaymentActivity.Ex_Language,(Boolean) arguments.get("language"));
      intent.putExtra(PaymentActivity.Ex_Name,(String) arguments.get("name"));
      intent.putExtra(PaymentActivity.Ex_Price,(double) arguments.get("price"));
      intent.putExtra(PaymentActivity.Ex_payment,(String)arguments.get("payment_method"));
      activity.startActivityForResult(intent,8888);
    } else {
      result.notImplemented();
    }
  }
  @SuppressWarnings("unused")
  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent intent) {
    if (requestCode == 8888) {
      if (resultCode == Activity.RESULT_OK) {
        HashMap<String, String> data = new HashMap<>();
        String response = intent.getStringExtra("data");
        data.put("code", "1");
        data.put("message", response);
        pendingResult.success(response);
      } else {
        HashMap<String, String> data = new HashMap<>();
        String response = intent.getStringExtra("data");
        data.put("code", "0");
        data.put("message", response);
        pendingResult.success(response);
      }
      pendingResult = null;
      arguments = null;
      return true;
    }
    return false;
  }

}
