//
//  UIView+GM.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/5.
//  Copyright © 2018 hitner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GM)

- (CGFloat)midX;
- (CGFloat)midY;
- (CGFloat)halfHeight;

- (void)roundingCorners:(UIRectCorner)corners;

- (void)enableFloatable:(BOOL)constrainToBound;

@end

NS_ASSUME_NONNULL_END
