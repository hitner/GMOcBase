//
//  GMFloatableView.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/14.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "GMFloatableView.h"
#import "UIView+GM.h"


@interface GMFloatableView()

@end

@implementation GMFloatableView



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
    self.layer.cornerRadius = 4.0;
    [self addTarget:self action:@selector(touchUpInsideView:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchDownRepeatOnView:event:) forControlEvents:UIControlEventTouchDownRepeat];
    [self enableFloatable:NO];
    return self;
    
}

- (void)touchUpInsideView:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didTouchUpInsideFloatableView:)]) {
        [self.delegate didTouchUpInsideFloatableView:self];
    }
}

- (void)touchDownRepeatOnView:(id)sender event:(UIEvent*)event {
    UITouch * touch = [event.allTouches anyObject];
    if (touch.tapCount == 2) {
        if ([self.delegate respondsToSelector:@selector(doubleClickOnView:)]) {
            [self.delegate doubleClickOnView:self];
        }
    }
}
@end
