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
     fontFamily:(NSString*)fileName
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
    [self setImageWithUrlString:url memoryCached:NO];
}

/// 有内存缓存的图片，用于多次显示的情况
- (void)setFrequentImageWithUrlString:(NSString *)url {
    [self setImageWithUrlString:url memoryCached:YES];
}


- (void)setImageWithUrlString:(NSString*)url
                 memoryCached:(BOOL)cached {
    if (!url || !url.length) {
        return ;
    }
    
    if (cached) {
        UIImage * cachedImage = [[GMCore sharedObject] idCacheObjectForKey:url];
        if (cachedImage) {
            NSAssert([cachedImage isKindOfClass:[UIImage class]], @"");
            if ([cachedImage isKindOfClass:[UIImage class]]) {
                [self setImage:cachedImage];
                return;
            }
             else {
                 // log warning
                 [[GMCore sharedObject] removeIdCacheObjectForKey:url];
             }
        }
    }
    
    weakifySelf
    [[GMCore sharedObject].concurrentQueue addOperationWithBlock:^{
        NSURL *URL = [NSURL URLWithString:url];
        NSError * error;
        NSData * data = [NSData dataWithContentsOfURL:URL options:0 error:&error];
        if (data && !error) {
            UIImage * image = [UIImage imageWithData:data];
            
            [[GMCore sharedObject].mainQueue addOperationWithBlock:^{
                strongifySelfReturnIfNil
                self.image = image;
                if (cached) {
                    [[GMCore sharedObject] addIdCache:image forKey:url];
                }
            }];
        }
    }];
}
@end
