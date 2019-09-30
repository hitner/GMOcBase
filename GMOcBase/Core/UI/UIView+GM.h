//
//  UIView+GM.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/5.
//  Copyright © 2018 hitner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    GMAlignAnchorUnavailable,
    GMAlignAnchorTop,
    GMAlignAnchorTopBottomCenter,
    GMAlignAnchorBottom,
    GMAlignAnchorLeft,
    GMAlignAnchorLeftRightCenter,
    GMAlignAnchorRight,
} GMAlignAnchor;


@interface UIView (GM)

- (CGFloat)midHorizontal;
- (CGFloat)midVertical;
- (CGFloat)halfHeight;
- (CGFloat)topY;
- (CGFloat)bottomY;
- (CGFloat)leftX;
- (CGFloat)rightX;

- (CGRect)rightFrameAnchor:(GMAlignAnchor)alignAnchor
                         leftMargin:(CGFloat)margin
                              width:(CGFloat)width
                             height:(CGFloat)height;

- (CGRect)bottomFrameAnchor:(GMAlignAnchor)alignAnchor
                           topMargin:(CGFloat)margin
                                     width:(CGFloat)width
                                    height:(CGFloat)height;
#pragma mark - 增加行为和能力
/* 使之能够手指拖动 */
- (void)enableFloatable:(BOOL)constrainToBound;

#pragma mark - 增加显示特效
/* 增加圆角4个角的圆角 */
- (void)maskCorners:(UIRectCorner)corners;

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

- (CAShapeLayer *)addAnimationArc;
#pragma mark - 布局与约束

///添加底部margin、x固定的约束
- (void)constraintToBottomView:(UIView*)bottomView
                  bottomMargin:(CGFloat)bottomMargin
                         xAxis:(CGFloat)x
                         width:(CGFloat)width
                        height:(CGFloat)height;

///添加底部margin、x轴对齐的约束
- (void)constraintToBottomView:(UIView*)bottomView
                  bottomMargin:(CGFloat)bottomMargin
                        xAlign:(GMAlignAnchor)align
                   alignMargin:(CGFloat)sideMargin
                         width:(CGFloat)width
                        height:(CGFloat)height;

///添加superview底部margin、x轴对齐margin的约束
- (void)constraintToSuperBottomMargin:(CGFloat)bottomMargin
                              xAlign:(GMAlignAnchor)align
                         alignMargin:(CGFloat)sideMargin
                               width:(CGFloat)width
                              height:(CGFloat)height;


@end

NS_ASSUME_NONNULL_END
