//
//  UIImage+App.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/30.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "UIImage+App.h"
#import "GMIcons.h"

@implementation UIImage (App)

+ (UIImage *)imageWithIcon:(NSString *)icon
           foregroundColor:(UIColor *)iconColor
           backgroundColor:(UIColor *)bgColor
                      size:(CGFloat)fontSize {
    return [UIImage imageWithIcon:icon
                  foregroundColor:iconColor
                  backgroundColor:bgColor
                             font:[UIFont fontWithName:kIconFamilyName size:fontSize]];
}
@end
