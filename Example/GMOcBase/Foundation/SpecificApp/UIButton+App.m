//
//  UIButton+App.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/29.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "UIButton+App.h"
#import "GMApperance.h"

@implementation UIButton (App)

///生成默认样式的button
+ (instancetype)primeButtonWithFrame:(CGRect)frame
                               title:(NSString*)title {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [GMApperance sharedObject].primeColor;
    button.tintColor = [UIColor whiteColor];
    button.layer.cornerRadius = 4.0;
    button.clipsToBounds = YES;
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

@end
