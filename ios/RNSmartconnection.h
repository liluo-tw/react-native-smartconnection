
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif
#import "SmartConnectionHelper.h"

@interface RNSmartconnection : NSObject <RCTBridgeModule>

@property SmartConnectionHelper *helper;

@end


