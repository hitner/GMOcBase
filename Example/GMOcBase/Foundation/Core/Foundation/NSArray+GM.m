//
//  NSArray+GM.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/4/28.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "NSArray+GM.h"
#import "NSString+GM.h"
#import "NSData+GM.h"

@implementation NSArray (GM)

- (NSString*) jsonString {
    return [NSString jsonStringFromId:self];
}

- (NSData*) jsonData {
    return [NSData jsonStringFromId:self];
}
@end
