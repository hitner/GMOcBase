//
//  UIImage+GM.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/28.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "UIImage+GM.h"

@implementation UIImage (GM)
+ (UIImage *)imageWithIcon:(NSString *)icon
           foregroundColor:(UIColor *)iconColor
           backgroundColor:(UIColor *)bgColor
                      size:(CGFloat)fontSize
                  fontFile:(NSString *)fontName
{
    //LZLogDurationBegin;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    if (icon == nil || [icon length] == 0 || font == nil) {
        return nil;
    }
    
    if (bgColor == nil) {
        bgColor = [UIColor clearColor];
    }
    if (iconColor == nil) {
        iconColor = [UIColor redColor];
    }
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSForegroundColorAttributeName : iconColor,
                                 NSBackgroundColorAttributeName : bgColor,
                                 NSParagraphStyleAttributeName: style,
                                 };
    
    // Calc size
    NSAttributedString*attString = [[NSAttributedString alloc]
                                    initWithString:icon
                                    attributes:attributes];
    // get the target bounding rect in order to center the icon within the UIImage:
    NSStringDrawingContext *ctx = [[NSStringDrawingContext alloc] init];
    CGRect textRect = [attString boundingRectWithSize:CGSizeMake(font.pointSize, font.pointSize)
                                              options:0
                                              context:ctx];
    textRect.origin.x = 0.f;
    textRect.origin.y = 0.f;
    
    
    // Draw
    UIGraphicsBeginImageContextWithOptions(textRect.size, NO, [[UIScreen mainScreen] scale]);
    
    //// Text Drawing
    [attString drawAtPoint:CGPointZero];
    
    //Image returns
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
@end
