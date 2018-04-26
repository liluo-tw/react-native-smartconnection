
#import "RNSmartconnection.h"
#import <React/RCTLog.h>

@implementation RNSmartconnection

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE(RNSmartconnection);

RCT_EXPORT_METHOD(startConnection: (NSString *)key
                 target: (NSString *)target
                 version: (NSNumber *)version
                 oldInterval: (float)oldInterval
                 newInterval: (float)newInterval
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"startConnection %@ %@ %d %f %f", key, target, version, oldInterval, newInterval);
    resolve([NSNumber numberWithInt:1]);
}

RCT_EXPORT_METHOD(sendConfiguration: (NSString *)ssid
                 pwd: (NSString *)pwd
                 authcode: (NSString *)authcode
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"sendConfiguration %@ %@ %@", ssid, pwd, authcode);
    resolve(@"");
}

RCT_EXPORT_METHOD(stopConnection: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"Stop smart connection");
    resolve(@"");
}

@end
