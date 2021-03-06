//
//  GMAppProfile.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2019/3/20.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "GMAppProfile.h"

@implementation GMAppProfile

IMPLEMENT_SIGNALTON()

- (instancetype)init {
    self = [super init];
    [self initReadonlyValue];
    
    return self;
}

- (void)initReadonlyValue {
    _screenSize = [[UIScreen mainScreen] bounds].size;
    
    _isIphoneXSerial = NO;
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.top > 24.0) {
            _isIphoneXSerial = YES;
        }
    }
    
}

- (CGFloat)screenWidth {
    return self.screenSize.width;
}

- (CGFloat)screenHeight {
    return self.screenSize.height;
}
/** 宽除以高的值
 */
- (CGFloat)screenWHRatio {
    return self.screenSize.width/self.screenSize.height;
}

- (void)logInfo {
    
    //GMLogCommon(GMLogLevelDebug,nil,@"sdkf%@",@"nil");
    GMLogDebug(@"HomeDirectory:%@",NSHomeDirectory());
    //字体
    for (NSString * family in [UIFont familyNames]) {
        GMLogInfo(@"familyNames:%@, font counts:%ld", family,[UIFont fontNamesForFamilyName:family].count);
//        for (NSString * name in [UIFont fontNamesForFamilyName:family]) {
//            NSLog(@"-font name: %@",name);
//        }
    }
}
@end
