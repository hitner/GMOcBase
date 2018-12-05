//
//  UIColor+GM.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/11/20.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "UIColor+GM.h"

@implementation UIColor (GM)

+ (instancetype)colorFromHexInteger:(NSInteger)hexvalue {
    return [self colorFromHexInteger:hexvalue alpha:1.0];
}

+ (instancetype)colorFromHexInteger:(NSInteger)hexvalue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:hexvalue>>16 green:(hexvalue>>8)&0xFF blue:hexvalue&0xFF alpha:alpha];
}

/**
 * 0xF3F3F380这种颜色定义
 */
+ (instancetype)colorFromLongHexInteger:(NSInteger)hexvalue {
    return [self colorFromHexInteger:hexvalue>>8 alpha:(hexvalue&0xFF)/0xFF];
}

@end
