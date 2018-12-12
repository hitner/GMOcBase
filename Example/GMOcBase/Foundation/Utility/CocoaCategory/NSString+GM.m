//
//  NSString+GM.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/5.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "NSString+GM.h"

@implementation NSString (GM)

- (id)jsonObject {
    NSError * error ;
    id result = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSAssert(error == nil, @"json serial error");
    if (error) {
        return nil;
    }
    else {
        return result;
    }
}

@end
