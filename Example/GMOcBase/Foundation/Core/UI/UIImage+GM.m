//
//  UIImage+GM.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/28.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "UIImage+GM.h"

@implementation UIImage (GM)
+ (void)imageWithIcon:(NSString *)icon
      foregroundColor:(UIColor *)iconColor
      backgroundColor:(UIColor *)bgColor
                 font:(UIFont*)font
               result:( void (^) (UIImage*) ) block;
{
    [[GMCore sharedObject].concurrentQueue addOperationWithBlock:^{
        UIImage * image = [UIImage imageWithIcon:icon
                                 foregroundColor:iconColor
                                 backgroundColor:bgColor
                                            font:font];
        if (block) {
            [[GMCore sharedObject].mainQueue addOperationWithBlock:^{
                block(image);
            }];
        }
    }];
}

/// font 的某个字符转图片
+ (UIImage *)imageWithIcon:(NSString *)icon
           foregroundColor:(UIColor *)iconColor
           backgroundColor:(UIColor *)bgColor
                      font:(UIFont*)font
{
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
    
    NSAttributedString*attString = [[NSAttributedString alloc]
                                    initWithString:icon
                                    attributes:attributes];
    //NSStringDrawingContext *ctx = [[NSStringDrawingContext alloc] init];
    
    // Calc size
    /*CGRect textRect = [attString boundingRectWithSize:CGSizeMake(font.pointSize, font.pointSize)
                                              options:0
                                              context:ctx];
    textRect.origin.x = 0.f;
    textRect.origin.y = 0.f;*/
    
    
    // Draw
    CGSize rectSize = CGSizeMake(font.pointSize, font.pointSize);
    UIGraphicsBeginImageContextWithOptions(rectSize, NO, [[UIScreen mainScreen] scale]);
    
    //// Text Drawing
    [attString drawAtPoint:CGPointZero];
    
    //Image returns
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
@end
