//
//  GMHttpManger.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/10/17.
//  Copyright © 2018年 hitner. All rights reserved.
//

#import "GMHttpManager.h"

@implementation GMHttpManager

+ (instancetype)sharedManager {
    static GMHttpManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[GMHttpManager alloc] init];
    });
    
    return _sharedInstance;
}

@end
