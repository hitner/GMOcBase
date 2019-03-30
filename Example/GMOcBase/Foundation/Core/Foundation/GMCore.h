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
DECLARE_SIGNALTON()
/// 并行执行队列
@property (nonatomic, readonly) NSOperationQueue* concurrentQueue;

/// 主线程执行队列 等价于[NSOperationQueue mainQueue]
- (NSOperationQueue*)mainQueue;
@end

NS_ASSUME_NONNULL_END
