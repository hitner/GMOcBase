//
//  GMCore.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/10/18.
//  Copyright © 2018年 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMCore : NSObject
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)singletonCore;
@property (nonatomic, readonly) NSOperationQueue* concurrentQueue;
@end

NS_ASSUME_NONNULL_END
