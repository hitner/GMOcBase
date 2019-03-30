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
    [[GMCore sharedObject].concurrentQueue addOperationWithBlock:^{
        UIImage * image= [UIImage imageWithIcon:iconName
                                foregroundColor:iconColor
                                backgroundColor:backColor
                                           size:MIN(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
                                       fontFile:fileName];
        [[GMCore sharedObject].mainQueue addOperationWithBlock:^{
            [self setImage:image];
        }];
    }];
}


/// 设置http url的图片(NSString*)
- (void)setImageWithUrlString:(NSString*)url {
    
}
@end
