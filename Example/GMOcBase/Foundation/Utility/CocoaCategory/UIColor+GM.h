//
//  UIColor+GM.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/11/20.
//  Copyright © 2018 hitner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (GM)

+ (instancetype)colorFromHexInteger:(NSInteger)hexvalue;
+ (instancetype)colorFromHexInteger:(NSInteger)hexvalue alpha:(CGFloat)alpha;

/**
 * 0xF3F3F380这种颜色定义
 */
+ (instancetype)colorFromLongHexInteger:(NSInteger)hexvalue;

@end

NS_ASSUME_NONNULL_END
