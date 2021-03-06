//
//  NSDictionary+GM.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/4/29.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (GM)
///转化为json字符串
- (NSString*) jsonString;

- (NSData*) jsonData;
@end

NS_ASSUME_NONNULL_END
