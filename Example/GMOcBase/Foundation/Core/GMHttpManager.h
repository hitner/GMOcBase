//
//  GMHttpManager.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/10/17.
//  Copyright © 2018年 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LGHttp;
NS_ASSUME_NONNULL_BEGIN

@interface GMHttpManager : NSObject
+ (instancetype)sharedManager;

@property(nonatomic) LGHttp * mainHost;
@end

NS_ASSUME_NONNULL_END
