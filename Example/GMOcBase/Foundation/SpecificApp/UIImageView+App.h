//
//  UIImageView+App.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/30.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (App)

/// iconfont的image
- (void)setIcon:(NSString*)iconName
foregroundColor:(UIColor*) iconColor
backgroundColor:(UIColor*) backColor;

/// 异步设置icon
- (void)setIcon:(NSString*)iconName
foregroundColor:(UIColor*) iconColor;

/// asynch set portrait
- (void)setPortraitURLString:(NSString*)url;
@end

NS_ASSUME_NONNULL_END
