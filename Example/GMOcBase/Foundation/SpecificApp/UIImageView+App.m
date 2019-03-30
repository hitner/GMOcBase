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
         fontFile:kIconFamilyName
  foregroundColor:iconColor
  backgroundColor:backColor];
}

@end
