//
//  GMUrlRouter.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/4/26.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "GMUrlRouter.h"

@interface GMUrlRouter()

@end

@implementation GMUrlRouter

IMPLEMENT_SIGNALTON()

- (void)registerUrlKey:(NSString*)key viewControllerClass:(Class)vcClass {
    
}

- (BOOL)navigateToUrl:(NSString *)url {
    return YES;
}
@end
