//
//  SmartConnectionHelper.h
//  SmartConnection
//
//  Created by Shuai Zhang  on 26/04/2018.
//  Copyright © 2018 Mediatek. All rights reserved.
//

#ifndef SmartConnectionHelper_h
#define SmartConnectionHelper_h

#import <Foundation/Foundation.h>
#import "elian.h"

@interface SmartConnectionHelper : NSObject

@property void *context;

- (void) initElian: (int)flag;
- (void) startElian;
- (void) stopElian;
- (void) setIntervalElian: (float)from to: (float)to;
- (void) setElianSSID: (NSString *)ssid;
- (void) setElianPWD: (NSString *)pwd;
- (void) setElianCustomInfo: (NSString *)info;
- (void) getElianVersion: (int *)protocol lib: (int *)lib;

@end

#endif /* SmartConnectionHelper_h */
