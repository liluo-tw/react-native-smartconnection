package com.luoli.smartconnection;

import com.mediatek.demo.smartconnection.JniLoader;

public class SmartConfigHelper {

    private static JniLoader jniLoader;
    private static boolean libLoaded = false;

    public static void init() {
        if (!libLoaded) {
            libLoaded = JniLoader.LoadLib();
        }
        if (libLoaded) {
            jniLoader = new JniLoader();
        }
    }

    public static int GetProtoVersion() {
        return jniLoader.GetProtoVersion();
    }

    public static int GetLibVersion() {
        return jniLoader.GetLibVersion();
    }

    public static int initConnection(String key, String target, int version) {
        int sendV1 = 0;
        int sendV4 = 1;
        int sendV5 = 0;

        if (version == 1) {
            sendV1 = 1;
            sendV4 = 0;
        }
        if (version == 5) {
            sendV4 = 0;
            sendV5 = 1;
        }

        return jniLoader.InitSmartConnection(key, target, sendV1, sendV4, sendV5);
    }

    public static int setSendInterval(float oldInterval, float newInterval) {
        return jniLoader.SetSendInterval(oldInterval, newInterval);
    }

    public static int startConnection(String SSID, String Password, String Custom) {
        return jniLoader.StartSmartConnection(SSID, Password, Custom);
    }

    public static int stopConnection() {
        return jniLoader.StopSmartConnection();
    }
}
