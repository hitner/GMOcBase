//
//  GMCore.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/10/18.
//  Copyright © 2018年 hitner. All rights reserved.
//

#import "GMCore.h"

@implementation GMCore

IMPLEMENT_SIGNALTON(GMCore)

- (instancetype)init {
    self = [super init];
    {
        _concurrentQueue = [[NSOperationQueue alloc] init];
        _concurrentQueue.name = @"main_concurrent_queue";
    }
    return self;
}

- (NSOperationQueue*)mainQueue {
    return [NSOperationQueue mainQueue];
}
@end
