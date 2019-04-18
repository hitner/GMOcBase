//
//  UIImage+GM.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/28.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GM)

/// 异步返回font字体下的某个字符的图片
+ (void)imageWithIcon:(NSString *)icon
           foregroundColor:(UIColor *)iconColor
           backgroundColor:(UIColor *)bgColor
                      font:(UIFont*)font
               result:( void (^) (UIImage*) ) block;


/// 同步 font 的某个字符转图片
+ (UIImage *)imageWithIcon:(NSString *)icon
           foregroundColor:(UIColor *)iconColor
           backgroundColor:(UIColor *)bgColor
                      font:(UIFont*)font;

/// 异步获得http url的图片
+ (void) imageWithURLString:(NSString*)url
                     result:( void (^) (UIImage* image, NSError*) ) block;
@end

NS_ASSUME_NONNULL_END
