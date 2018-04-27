
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
    @try {
        _helper = [[SmartConnectionHelper alloc] init];
        int proV = 0;
        int libV = 0;
        [_helper getElianVersion:&proV lib:&libV];
        RCTLogInfo(@"Smartconfig libVersion: %d protoVersion: %d)", libV, proV);
        [_helper initElian:(int)version];
        [_helper setIntervalElian:oldInterval to:newInterval];
        [_helper startElian];
        resolve([@(libV) stringValue]);
    }
    @catch (NSException *exception) {
        if (_helper != NULL) {
            [_helper stopElian];
        }
        NSDictionary *data = exception.userInfo;
        NSString *msg = [data objectForKey:@"msg"];
        NSString *errorCode = [data objectForKey:@"code"];
        reject(errorCode, msg, nil);
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
        [_helper setElianSSID:ssid];
        [_helper setElianPWD:pwd];
        [_helper setElianCustomInfo:authcode];
        resolve(@"");
    }
    @catch (NSException *exception) {
        if (_helper != NULL) {
            [_helper stopElian];
        }
        NSDictionary *data = exception.userInfo;
        NSString *msg = [data objectForKey:@"msg"];
        NSString *errorCode = [data objectForKey:@"code"];
        reject(errorCode, msg, nil);
    }
}

RCT_REMAP_METHOD(stopConnection,
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"Stop smart connection");
    @try {
        [_helper stopElian];
        resolve(@"");
    }
    @catch (NSException *exception) {
        NSDictionary *data = exception.userInfo;
        NSString *msg = [data objectForKey:@"msg"];
        NSString *errorCode = [data objectForKey:@"code"];
        reject(errorCode, msg, nil);
    }
}

@end

