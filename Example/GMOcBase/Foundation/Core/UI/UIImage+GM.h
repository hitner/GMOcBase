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

/// 异步返回图片
+ (void)imageWithIcon:(NSString *)icon
           foregroundColor:(UIColor *)iconColor
           backgroundColor:(UIColor *)bgColor
                      font:(UIFont*)font
               result:( void (^) (UIImage*) ) block;


/// font 的某个字符转图片
+ (UIImage *)imageWithIcon:(NSString *)icon
           foregroundColor:(UIColor *)iconColor
           backgroundColor:(UIColor *)bgColor
                      font:(UIFont*)font;
@end

NS_ASSUME_NONNULL_END
