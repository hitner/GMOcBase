//
//  GMURLSessionManager.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/31.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "GMURLSessionManager.h"

@implementation GMURLSessionManager
IMPLEMENT_SIGNALTON()

-(instancetype)init {
    self = [super init];
    _commonMainQueueSession = [NSURLSession sessionWithConfiguration:
                               [NSURLSessionConfiguration defaultSessionConfiguration]
                                                            delegate:nil
                                                       delegateQueue:[GMCore sharedObject].mainQueue];
    return self;
}
@end
