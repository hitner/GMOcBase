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

- (NSString *)hexadecimalString {
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */

    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];

    if (!dataBuffer)
        return [NSString string];

    NSUInteger          dataLength  = [self length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];

    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lX", (unsigned long)dataBuffer[i]]];

    return [NSString stringWithString:hexString];
}
@end
