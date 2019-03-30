//
//  UIImageView+GM.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/28.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "UIImageView+GM.h"
#import "UIImage+GM.h"


@implementation UIImageView (GM)

- (void)setIcon:(NSString*)iconName
       fontFile:(NSString*)fileName
foregroundColor:(UIColor*) iconColor
backgroundColor:(UIColor*) backColor
{
    CGFloat size = MIN(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    weakifySelf
    [UIImage imageWithIcon:iconName
           foregroundColor:iconColor
           backgroundColor:backColor
                      font:[UIFont fontWithName:fileName size:size]
                    result:^(UIImage * _Nonnull image) {
                        strongifySelfReturnIfNil
        self.image = image;
    }];
}


/// 设置http url的图片(NSString*)
- (void)setImageWithUrlString:(NSString*)url {
    
}
@end
