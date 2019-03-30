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
+ (UIImage *)imageWithIcon:(NSString *)icon
           foregroundColor:(UIColor *)iconColor
           backgroundColor:(UIColor *)bgColor
                      size:(CGFloat)fontSize
                  fontFile:(NSString *)fontName;


@end

NS_ASSUME_NONNULL_END
