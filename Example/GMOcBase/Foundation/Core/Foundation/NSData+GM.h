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
@end

NS_ASSUME_NONNULL_END
