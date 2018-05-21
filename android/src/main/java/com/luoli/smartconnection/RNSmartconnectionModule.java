
package com.luoli.smartconnection;

import android.content.Context;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.util.Log;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class RNSmartconnectionModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;
  private final WifiManager wifiManager;

  public RNSmartconnectionModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
    this.wifiManager = (WifiManager) reactContext.getApplicationContext()
            .getSystemService(Context.WIFI_SERVICE);
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
      promise.resolve(libVersion);
    } catch (Exception e) {
      promise.reject(e);
    }
  }

  @ReactMethod
  public void sendConfiguration(String ssid, String ssidpwd, String authcode,
                                Promise promise) {
    try {
      SmartConfigHelper.startConnection(ssid, ssidpwd, authcode);
      promise.resolve("");
    } catch (Exception e) {
      e.printStackTrace();
      promise.reject(e);
    }
  }

  @ReactMethod
  public void stopConnection(Promise promise) {
    try {
      SmartConfigHelper.stopConnection();
      promise.resolve("");
    } catch (Exception e) {
      e.printStackTrace();
      promise.reject(e);
    }

  }

  @ReactMethod
  public void getSSID(Promise promise) {
    WifiInfo info = wifiManager.getConnectionInfo();
    if (!info.getSSID().isEmpty()) {
      String name = info.getSSID();
      String ssid = name.substring(1, name.length() - 1);
      promise.resolve(ssid);
    } else {
      promise.reject("getSSID", "get SSID failed");
    }
  }

  @ReactMethod
  public void getBSSID(Promise promise) {
    WifiInfo info = wifiManager.getConnectionInfo();
    if (!info.getBSSID().isEmpty()) {
      String bssid = info.getBSSID();
      promise.resolve(bssid);
    } else {
      promise.reject("getBSSID", "get BSSID failed");
    }
  }
}