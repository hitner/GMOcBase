//
//  NSDictionary+GM.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/4/29.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "NSDictionary+GM.h"
#import "NSString+GM.h"
#import "NSData+GM.h"

@implementation NSDictionary (GM)
- (NSString*) jsonString {
    return [NSString jsonStringFromId:self];
}

- (NSData*) jsonData {
    return [NSData jsonStringFromId:self];
}
@end
