//
//  UIColor+GM.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/11/20.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "UIColor+GM.h"



@implementation UIColor (GM)

+ (instancetype)RGB:(NSInteger)hexValue {
    return [self colorFromRGBInteger:hexValue alpha:1.0];
}

+ (instancetype)colorFromRGBInteger:(NSInteger)hexvalue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(hexvalue>>16)/255.f
                           green:((hexvalue>>8)&0xFF)/255.f
                            blue:(hexvalue&0xFF)/255.f
                           alpha:alpha];
}

/**
 * 0xF3F3F380这种颜色定义
 */
+ (instancetype)colorFromRGBAInteger:(NSInteger)hexvalue {
    return [self colorFromRGBInteger:hexvalue>>8 alpha:(hexvalue&0xFF)/0xFF];
}

+ (instancetype)colorFromARGBInteger:(NSInteger)hexvalue {
    return [self colorFromRGBInteger:hexvalue&0xFFFFFF alpha:(hexvalue>>24)/0xFF];
}

+ (instancetype)colorFromRGBAString:(NSString*)hexStr {
    return nil;
}

+ (instancetype)blackColorWithAlpha:(CGFloat)alpha {
    return [[UIColor blackColor] colorWithAlphaComponent:alpha];
}

/// convinient white color with alpha
+ (instancetype)whiteColorWithAlpha:(CGFloat)alpha {
    return [[UIColor blackColor] colorWithAlphaComponent:alpha];
}
@end
