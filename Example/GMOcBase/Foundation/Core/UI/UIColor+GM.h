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

/// from hex integer
+ (instancetype)RGB:(NSInteger)hexValue;

+ (instancetype)colorFromRGBInteger:(NSInteger)hexvalue alpha:(CGFloat)alpha;

/**
 * 0xF3F3F380这种颜色定义
 */
+ (instancetype)colorFromRGBAInteger:(NSInteger)hexvalue;


+ (instancetype)colorFromARGBInteger:(NSInteger)hexvalue;

/**
 * 支持格式 "0xF3ABC3FF" "#304040FF" "2378A9FF" 
 */
+ (instancetype)colorFromRGBAString:(NSString*)hexStr;

/// convinient black color alpha
+ (instancetype)blackColorWithAlpha:(CGFloat)alpha;

/// convinient white color with alpha
+ (instancetype)whiteColorWithAlpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
