
#import "RNSmartconnection.h"
#import <React/RCTLog.h>

@implementation RNSmartconnection

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE(RNSmartconnection);

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
    resolve(@"1");
}

RCT_REMAP_METHOD(sendConfiguration,
                 ssid: (NSString *)ssid
                 pwd: (NSString *)pwd
                 authcode: (NSString *)authcode
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"sendConfiguration %@ %@ %@", ssid, pwd, authcode);
    resolve(@"");
}

RCT_REMAP_METHOD(stopConnection,
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"Stop smart connection");
    resolve(@"");
}

@end
