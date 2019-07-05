//
//  GMAppProfile.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2019/3/20.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMMacro.h"

NS_ASSUME_NONNULL_BEGIN

#define APP_PROFILE [GMAppProfile sharedObject]

@interface GMAppProfile : NSObject
DECLARE_SIGNALTON()
@property (nonatomic,readonly) BOOL isIphoneXSerial;

//44 or 20
@property (nonatomic,readonly) CGFloat statusBarHeight;


@property (nonatomic,readonly) CGSize screenSize;

- (CGFloat)screenWidth;
- (CGFloat)screenHeight;
/**
 宽除以高的值
 */
- (CGFloat)screenWHRatio;

- (void)logInfo;
@end

NS_ASSUME_NONNULL_END
