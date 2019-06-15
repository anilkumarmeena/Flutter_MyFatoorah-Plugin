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
      Intent intent = new Intent(activity,MyfatoorahActivity.class);
      activity.startActivityForResult(intent,8888);
      //result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }

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
