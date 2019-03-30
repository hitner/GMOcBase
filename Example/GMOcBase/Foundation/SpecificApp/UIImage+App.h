//
//  UIImage+App.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/30.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (App)
+ (UIImage *)imageWithIcon:(NSString *)icon
           foregroundColor:(UIColor *)iconColor
           backgroundColor:(UIColor *)bgColor
                      size:(CGFloat)fontSize;
@end

NS_ASSUME_NONNULL_END
