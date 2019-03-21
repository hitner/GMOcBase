//
//  UIView+GM.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/5.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "UIView+GM.h"

@implementation UIView (GM)

- (CGFloat)midX {
    return CGRectGetMidX(self.frame);
}

- (CGFloat)midY {
    return CGRectGetMidY(self.frame);
}

- (CGFloat)halfHeight {
    return CGRectGetHeight(self.frame)/2.f;
}

- (void)roundingCorners:(UIRectCorner)corners {
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

@end
