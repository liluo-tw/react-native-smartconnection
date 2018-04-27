
#import "RNSmartconnection.h"
#import <React/RCTLog.h>
#import "SmartConnectionHelper.h"

@implementation RNSmartconnection

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE(RNSmartconnection);

SmartConnectionHelper *helper;

RCT_REMAP_METHOD(startConnection,
                 key: (NSString *)key
                 target: (NSString *)target
                 version: (NSInteger)version
                 oldInterval: (float)oldInterval
                 newInterval: (float)newInterval
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"startConnection %@ %@ %zd %f %f", key, target, version, oldInterval, newInterval);
    @try {
        helper = [[SmartConnectionHelper alloc] init];
        int proV = 0;
        int libV = 0;
        [helper getElianVersion:&proV lib:&libV];
        RCTLogInfo(@"Smartconfig libVersion: %d protoVersion: %d)", libV, proV);
        [helper initElian:version];
        [helper setIntervalElian:oldInterval to:newInterval];
        [helper startElian];
        resolve(@"%d", libV);
    }
    @catch (NSException *exception) {
        if (helper != NULL) {
            [helper stopElian];
        }
        reject(exception);
    }
}

RCT_REMAP_METHOD(sendConfiguration,
                 ssid: (NSString *)ssid
                 pwd: (NSString *)pwd
                 authcode: (NSString *)authcode
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"sendConfiguration %@ %@ %@", ssid, pwd, authcode);
    @try {
        [helper setElianSSID:ssid];
        [helper setElianPWD:pwd];
        [helper setElianCustomInfo:authcode];
        resolve(@"");
    }
    @catch (NSException *exception) {
        if (helper != NULL) {
            [helper stopElian];
        }
        reject(exception);
    }
}

RCT_REMAP_METHOD(stopConnection,
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"Stop smart connection");
    @try {
        [helper stopElian];
        resolve(@"");
    }
    @catch (NSException *exception) {
        reject(exception)
    }
}

@end
