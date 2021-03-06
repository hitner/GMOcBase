//
//  UIView+GM.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/5.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "UIView+GM.h"

@implementation UIView (GM)

- (CGFloat)midHorizontal {
    return CGRectGetMidX(self.frame);
}

- (CGFloat)midVertical {
    return CGRectGetMidY(self.frame);
}

- (CGFloat)halfHeight {
    return CGRectGetHeight(self.frame)/2.f;
}

- (CGFloat)topY {
    return CGRectGetMinY(self.frame);
}
- (CGFloat)bottomY {
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)leftX {
    return CGRectGetMinX(self.frame);
}
- (CGFloat)rightX {
    return CGRectGetMaxX(self.frame);
}

- (CGRect)rightFrameAnchor:(GMAlignAnchor)alignAnchor
                         leftMargin:(CGFloat)margin
                              width:(CGFloat)width
                             height:(CGFloat)height {
    NSAssert(alignAnchor == GMAlignAnchorTop
             || alignAnchor == GMAlignAnchorBottom
             || alignAnchor == GMAlignAnchorTopBottomCenter, @"align anchor error");
    
    CGFloat y = [self topY];
    if (alignAnchor == GMAlignAnchorTopBottomCenter) {
        y = y + (CGRectGetHeight(self.frame) - height)/2.0;
    }
    else if (alignAnchor == GMAlignAnchorBottom) {
        y = y + CGRectGetHeight(self.frame) - height;
    }
    
    return CGRectMake([self rightX] + margin, y, width, height);
    
}

- (CGRect)bottomFrameAnchor:(GMAlignAnchor)alignAnchor
                           topMargin:(CGFloat)margin
                               width:(CGFloat)width
                              height:(CGFloat)height {
    NSAssert(alignAnchor == GMAlignAnchorLeft
             || alignAnchor == GMAlignAnchorLeftRightCenter
             || alignAnchor == GMAlignAnchorRight, @"align anchor error");
    
    CGFloat x = [self leftX];
    if (alignAnchor == GMAlignAnchorLeftRightCenter) {
        x = x + (CGRectGetWidth(self.frame) - width)/2.0;
    }
    else if (alignAnchor == GMAlignAnchorRight) {
        x = x + CGRectGetWidth(self.frame) - width;
    }
    
    return CGRectMake(x, [self bottomY] + margin, width, height);
}


- (void)maskCorners:(UIRectCorner)corners {
    CGFloat radii = [self halfHeight];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radii, radii)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)enableFloatable:(BOOL)constrainToBound {
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer * recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
    [self addGestureRecognizer:recognizer];
}

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer*)recognizer {
    static CGPoint stateBeganCenter;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            stateBeganCenter = self.center;
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self];
            self.center = CGPointMake(stateBeganCenter.x + translation.x, stateBeganCenter.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            CGRect bound = self.superview.bounds;
            if (!CGRectContainsRect(bound, self.frame)) {
                CGRect newFrame = self.frame;
                if (CGRectGetMinX(newFrame) < 0) {
                    newFrame.origin.x = 0;
                }
                if (CGRectGetMaxX(newFrame) > CGRectGetWidth(bound)) {
                    newFrame.origin.x = CGRectGetWidth(bound) - CGRectGetWidth(newFrame);
                }
                if (CGRectGetMinY(newFrame) < 0) {
                    newFrame.origin.y = 0;
                }
                if (CGRectGetMaxY(newFrame) > CGRectGetHeight(bound)) {
                    newFrame.origin.y = CGRectGetHeight(bound) - CGRectGetHeight(newFrame);
                }
                [UIView animateWithDuration:0.25 animations:^{
                    self.frame = newFrame;
                }];
            }
        }
        default:
            break;
    }
}

- (UIVisualEffectView *)addBlurEffect:(UIBlurEffectStyle)style {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [effectView setUserInteractionEnabled:NO];
    effectView.frame = self.bounds;
    [self addSubview:effectView];
    return effectView;
}


- (CAGradientLayer *)addGradientWithLeftColor:(UIColor*) startColor
                                   rightColor:(UIColor*) endColor {
    
    return [self addGradientWithColors:@[startColor, endColor]
                             locations:@[@(0),@(1)]
                            startPoint:CGPointMake(0, 0.5)
                              endPoint:CGPointMake(1, 0.5)];
}

- (CAGradientLayer *)addGradientWithTopColor:(UIColor*) startColor
                                 bottomColor:(UIColor*) endColor {
    return [self addGradientWithColors:@[startColor, endColor]
                             locations:@[@(0),@(1)]
                            startPoint:CGPointMake(0.5, 0)
                              endPoint:CGPointMake(0.5, 1)];
}

- (CAGradientLayer *)addGradientWithColors:(NSArray<UIColor*>*) colors
                                 locations:(NSArray<NSNumber*>*)locations
                                startPoint:(CGPoint)startPoint
                                  endPoint:(CGPoint)endPoint {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    NSMutableArray *cgcolors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgcolors addObject:(id)color.CGColor];
    }
    gradientLayer.colors = cgcolors;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    [self.layer addSublayer:gradientLayer];
    return gradientLayer;
}

#pragma mark - 布局约束部分
///添加到左边、底部的约束,bottomView为nil表示距离底部的superView
- (void)constraintToBottomView:(UIView*)bottomView
                  bottomMargin:(CGFloat)bottomMargin
                         xAxis:(CGFloat)x
                         width:(CGFloat)width
                        height:(CGFloat)height {
    NSAssert(self.superview,@"must add to superview");
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint * bottomConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:-bottomMargin];
    
    NSLayoutConstraint * widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    
    NSLayoutConstraint * heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    
    if (self.superview) {
        [self.leftAnchor constraintEqualToAnchor:self.superview.leftAnchor constant:x].active = YES;
    };
    
    bottomConstraint.active = YES;
    widthConstraint.active = YES;
    heightConstraint.active = YES;
}


///添加底部margin、x轴对齐的约束
- (void)constraintToBottomView:(UIView*)bottomView
                  bottomMargin:(CGFloat)bottomMargin
                        xAlign:(GMAlignAnchor)align
                   alignMargin:(CGFloat)sideMargin
                         width:(CGFloat)width
                        height:(CGFloat)height {
    NSAssert(align == GMAlignAnchorUnavailable ||
             align == GMAlignAnchorLeft ||
             align == GMAlignAnchorRight ||
             align == GMAlignAnchorLeftRightCenter, @"align error");
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.widthAnchor constraintEqualToConstant:width].active = YES;
    [self.heightAnchor constraintEqualToConstant:height].active = YES;
    [self.bottomAnchor constraintEqualToAnchor:bottomView.topAnchor constant:-bottomMargin].active = YES;
    
    if (align == GMAlignAnchorLeft) {
        [self.leftAnchor constraintEqualToAnchor:bottomView.leftAnchor constant:sideMargin].active = YES;
    }
    else if (align == GMAlignAnchorLeftRightCenter) {
        [self.centerXAnchor constraintEqualToAnchor:bottomView.centerXAnchor constant:sideMargin].active = YES;
    }
    else if (align == GMAlignAnchorRight) {
        [self.rightAnchor constraintEqualToAnchor:bottomView.rightAnchor constant:-sideMargin].active = YES;
    }
}

///添加superview底部margin、x轴对齐margin的约束
- (void)constraintToSuperBottomMargin:(CGFloat)bottomMargin
                              xAlign:(GMAlignAnchor)align
                         alignMargin:(CGFloat)sideMargin
                               width:(CGFloat)width
                              height:(CGFloat)height {
    NSAssert(self.superview, @"must addTo superview");
    NSAssert(align == GMAlignAnchorUnavailable ||
             align == GMAlignAnchorLeft ||
             align == GMAlignAnchorRight ||
             align == GMAlignAnchorLeftRightCenter, @"align error");
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.widthAnchor constraintEqualToConstant:width].active = YES;
    [self.heightAnchor constraintEqualToConstant:height].active = YES;
    if (self.superview) {
        [self.bottomAnchor constraintEqualToAnchor:self.superview.safeAreaLayoutGuide.bottomAnchor constant:-bottomMargin].active = YES;
        
        if (align == GMAlignAnchorLeft) {
            [self.leftAnchor constraintEqualToAnchor:self.superview.leftAnchor constant:sideMargin].active = YES;
        }
        else if (align == GMAlignAnchorLeftRightCenter) {
            [self.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor constant:sideMargin].active = YES;
        }
        else if (align == GMAlignAnchorRight) {
            [self.rightAnchor constraintEqualToAnchor:self.superview.rightAnchor constant:-sideMargin].active = YES;
        }
    }
}
@end
