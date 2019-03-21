//
//  GMCore.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/10/18.
//  Copyright © 2018年 hitner. All rights reserved.
//

#import "GMCore.h"

@implementation GMCore

+ (instancetype)singletonCore;
{
    static GMCore *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    {
        _concurrentQueue = [[NSOperationQueue alloc] init];
        _concurrentQueue.name = @"main_concurrent_queue";
    }
    return self;
}

@end
