//
//  UIViewController+GM.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/27.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "UIViewController+GM.h"

@implementation UIViewController (GM)

- (void)setNavigationTitle:(NSString*)title {
    [self setNavigationTitle:title target:nil backAction:nil];
}

- (void)setNavigationTitle:(NSString *)title backAction:(SEL)selector {
    [self setNavigationTitle:title target:self backAction:selector];
}

- (void)setNavigationTitle:(NSString *)title target:(id) target backAction:(SEL)selector {
    [self.navigationItem setTitle:title];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:target action:selector];
}
@end
