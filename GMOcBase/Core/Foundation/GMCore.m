//
//  GMCore.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/10/18.
//  Copyright © 2018年 hitner. All rights reserved.
//

#import "GMCore.h"

#define kIdCacheMaxItems 20


@interface GMCore()
/// id (UIImage* etc.) cache,use only in main thread!
@property (nonatomic) NSMutableDictionary * idCache;
@end


@implementation GMCore

IMPLEMENT_SIGNALTON()

- (instancetype)init {
    self = [super init];
    if (self){
        [self initReadonly];

    }
    return self;
}

- (void)initReadonly{
    _concurrentQueue = [[NSOperationQueue alloc] init];
    _concurrentQueue.name = @"main_concurrent_queue";
    _idCache = [[NSMutableDictionary alloc] init];
}

- (NSOperationQueue*)mainQueue {
    return [NSOperationQueue mainQueue];
}

- (void)addIdCache:(id)object forKey:(NSString*)key {
    
    if ([self.idCache count] >= kIdCacheMaxItems) {
        [self.idCache removeAllObjects];
        //TODO: more good !
    }
    
    self.idCache[key] = object;
}

- (id)idCacheObjectForKey:(NSString*)key {
    return [self.idCache objectForKey:key];
}

- (void)removeIdCacheObjectForKey:(NSString*)key {
    [self.idCache removeObjectForKey:key];
}

- (void)initLogger {
    
}
@end
