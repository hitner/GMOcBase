//
//  GMFloatableView.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/14.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "GMFloatableView.h"

@interface GMFloatableView()
@property(nonatomic) CGPoint stateBeganCenter;
@end

@implementation GMFloatableView



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
    self.layer.cornerRadius = 4.0;
    [GMFloatableView enableFloatableToView:self delegate:nil];
    
    return self;
    
}

+ (void)enableFloatableToView:(UIView*)view delegate:(id<GMFloatableViewDelegate>) delegate {
    view.userInteractionEnabled = YES;
    UIPanGestureRecognizer * recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:view action:@selector(handlePanGestureRecognizer:)];
    [view addGestureRecognizer:recognizer];
    
    
}

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer*)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.stateBeganCenter = self.center;
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self];
            self.center = CGPointMake(self.stateBeganCenter.x + translation.x, self.stateBeganCenter.y + translation.y);
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
@end
