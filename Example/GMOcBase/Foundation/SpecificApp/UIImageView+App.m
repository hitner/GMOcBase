//
//  UIImageView+App.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/30.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "UIImageView+App.h"

#import "GMIcons.h"

@implementation UIImageView (App)


- (void)setIcon:(NSString*)iconName
foregroundColor:(UIColor*) iconColor
backgroundColor:(UIColor*) backColor
{
    [self setIcon:iconName
         fontFamily:kIconFamilyName
  foregroundColor:iconColor
  backgroundColor:backColor];
}


- (void)setIcon:(NSString*)iconName
foregroundColor:(UIColor*) iconColor {
    [self setIcon:iconName
  foregroundColor:iconColor
  backgroundColor:[UIColor clearColor]];
}
@end
