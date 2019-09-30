//
//  NSData+GM.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/4/29.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (GM)
/// 把NSArray/NSDictionary 转为NSData
+ (instancetype)jsonStringFromId:(id)object;

/// 转化为大写的16进制的string，不要使用description
- (NSString *)hexadecimalString;

@end

NS_ASSUME_NONNULL_END
