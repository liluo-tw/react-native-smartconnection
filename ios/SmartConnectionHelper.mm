//
//  SmartConnectionHelper.m
//  SmartConnection
//
//  Created by Shuai Zhang  on 26/04/2018.
//  Copyright © 2018 Mediatek. All rights reserved.
//
#import "SmartConnectionHelper.h"

@implementation SmartConnectionHelper

#pragma mark - elian
- (void) initElian: (int)flag {
    unsigned char target[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
    if (flag == 1) {
        flag = ELIAN_VERSION_V1;
    } else if (flag == 4) {
        flag = ELIAN_VERSION_V4;
    } else if (flag == 5) {
        flag = ELIAN_VERSION_V5;
    } else {
        [[self createException:@"Please Select At Least 1 Version To Send" code:0xff] raise];
    }
    _context = elianNew(NULL, 0, target, flag);
    if (_context == NULL) {
        [[self createException:@"Failed To Create Context" code:0xff] raise];
    }
}

- (void) startElian {
    int retValue = ELIAN_ERROR_CODE_OK;
    retValue = elianStart(_context);
    if (retValue != ELIAN_ERROR_CODE_OK) {
        [[self createException:@"Failed To Start Smart Connection" code: retValue] raise];
    }
}

- (void) stopElian {
    if (_context != NULL) {
        elianStop(_context);
        elianDestroy(_context);
    }
}

- (void) setIntervalElian: (float)from to: (float)to {
    int retValue = ELIAN_ERROR_CODE_OK;
    if (from != 0.0 || to != 0.0) {
        retValue = elianSetInterval(_context, from * 1000, to * 1000);
    }
    if (retValue != ELIAN_ERROR_CODE_OK) {
        [[self createException:@"Failed To Set Sending Interval" code:retValue] raise];
    }
}

- (void) setElianSSID: (NSString *)ssid {
    [self putElian:ssid type:TYPE_ID_SSID error:@"Failed To Set SSID"];
}

- (void) setElianPWD: (NSString *)pwd {
    [self putElian:pwd type:TYPE_ID_PWD error:@"Failed To Set Password"];
}

- (void) setElianCustomInfo: (NSString *)info {
    [self putElian:info type:TYPE_ID_CUST error:@"Failed To Set Customer Info"];
}

- (void) putElian: (NSString *)data type: (enum etype_id) type error: (NSString *)error {
    int retValue = ELIAN_ERROR_CODE_OK;
    if ([data isEqualToString:@""] == NO) {
        const char *info = [data UTF8String];
        retValue = elianPut(_context, type, (char *)info, (int)strlen(info));
    }
    if (retValue != ELIAN_ERROR_CODE_OK) {
        [[self createException:error code:retValue] raise];
    }
}

- (void) getElianVersion: (int *)protocol lib: (int *)lib {
    elianGetVersion(protocol, lib);
}

- (NSException *) createException: (NSString *)msg code:(int)code {
    NSDictionary *userInfo = @{@"msg": msg, @"code": [NSNumber numberWithInt:code]};
    return [NSException exceptionWithName:@"Elian Exception" reason:msg userInfo:userInfo];
}

@end
