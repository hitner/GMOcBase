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

/// get cached object. main thread only!
- (id)idCacheObjectForKey:(NSString*)key;
///add id to memoryCache. main thread only!
- (void)addIdCache:(id)object forKey:(NSString*)key;
///remove id chached object. main thread only!
- (void)removeIdCacheObjectForKey:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
