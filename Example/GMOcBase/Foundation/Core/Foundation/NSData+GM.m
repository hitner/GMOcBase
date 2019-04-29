//
//  NSData+GM.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/4/29.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "NSData+GM.h"

@implementation NSData (GM)
+ (instancetype)jsonStringFromId:(id)object {
    NSError * error;
    NSData * data =[NSJSONSerialization dataWithJSONObject:object
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    NSAssert(!error,@"array to json data,error:%@", error.localizedDescription);
    return data;
}
@end
