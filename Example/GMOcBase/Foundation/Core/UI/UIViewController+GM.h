//
//  UIViewController+GM.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/27.
//  Copyright © 2019 hitner. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GM)

///导航标题
- (void)setNavigationTitle:(NSString*)title;

///导航标题+back时的回调
- (void)setNavigationTitle:(NSString *)title backAction:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
