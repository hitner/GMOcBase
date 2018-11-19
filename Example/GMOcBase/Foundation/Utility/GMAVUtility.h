//
//  GMAVUtility.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/11/14.
//  Copyright © 2018 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMAVUtility : NSObject

+ (void)requestVideoAuthorization:(NSString*)failedTip completionHandler:(void (^)())handler;
+ (void)requestMicroAuthorization:(NSString*)failedTip completionHandler:(void (^)())handler;
@end

NS_ASSUME_NONNULL_END
