
package com.luoli.smartconnection;

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
}