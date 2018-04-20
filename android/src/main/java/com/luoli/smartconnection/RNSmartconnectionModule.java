
package com.luoli.smartconnection;

import android.util.Log;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

public class RNSmartconnectionModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNSmartconnectionModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNSmartconnection";
  }

  @ReactMethod
  public void startConnection(String key, String target, Integer version, Float oldInterval, Float newInterval,
                              Promise promise) {
    try {
      SmartConfigHelper.init();
      int libVersion = SmartConfigHelper.GetLibVersion();
      int protoVersion = SmartConfigHelper.GetProtoVersion();
      Log.i("Smartconfig", "libVersion: " + libVersion + ", protoVersion: " + protoVersion);
      SmartConfigHelper.initConnection(key, target, version);
      SmartConfigHelper.setSendInterval(oldInterval, newInterval);
      promise.resolve(System.currentTimeMillis());
    } catch (Exception e) {
      promise.reject(e.getCause());
    }
  }

  @ReactMethod
  public void sendConfiguration(String ssid, String ssidpwd, String authcode,
                                Promise promise) {
    try {
      SmartConfigHelper.startConnection(ssid, ssidpwd, authcode);
      promise.resolve(System.currentTimeMillis());
    } catch (Exception e) {
      e.printStackTrace();
      promise.reject(e.getCause());
    }
  }

  @ReactMethod
  public void stopConnection() {
    try {
      SmartConfigHelper.stopConnection();
    } catch (Exception e) {
      e.printStackTrace();
    }

  }
}