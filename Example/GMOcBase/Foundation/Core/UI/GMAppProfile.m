//
//  GMAppProfile.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2019/3/20.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "GMAppProfile.h"

@implementation GMAppProfile

IMPLEMENT_SIGNALTON(GMAppProfile)

- (instancetype)init {
    self = [super init];
    //-----
    _isIphoneXSerial = NO;
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.top > 24.0) {
            _isIphoneXSerial = YES;
        }
    }
    //-----
    return self;
}
@end
