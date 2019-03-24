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

/* 增加圆角4个角的圆角 */
- (void)maskCorners:(UIRectCorner)corners;

/* 使之能够手指拖动 */
- (void)enableFloatable:(BOOL)constrainToBound;

/* 添加模糊效果，作为subview*/
- (UIVisualEffectView *)addBlurEffect:(UIBlurEffectStyle)style;

/* 添加颜色渐变层 */
- (CAGradientLayer *)addGradientWithLeftColor:(UIColor*) startColor
                      rightColor:(UIColor*) endColor;

- (CAGradientLayer *)addGradientWithTopColor:(UIColor*) startColor
                    bottomColor:(UIColor*) endColor;

- (CAGradientLayer *)addGradientWithColors:(NSArray<UIColor*>*) colors
                                 locations:(NSArray<NSNumber*>*)locations
                                startPoint:(CGPoint)startPoint
                                  endPoint:(CGPoint)endPoint;



@end

NS_ASSUME_NONNULL_END
