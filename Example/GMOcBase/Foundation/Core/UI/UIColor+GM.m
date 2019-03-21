//
//  UIColor+GM.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/11/20.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "UIColor+GM.h"

@implementation UIColor (GM)

+ (instancetype)colorFromRGBInteger:(NSInteger)hexvalue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:hexvalue>>16 green:(hexvalue>>8)&0xFF blue:hexvalue&0xFF alpha:alpha];
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
@end
