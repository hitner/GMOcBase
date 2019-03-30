//
//  UIButton+App.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/29.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (App)

///生成默认样式的button
+ (instancetype)primeButtonWithFrame:(CGRect)frame
                               title:(NSString*)title;
@end

NS_ASSUME_NONNULL_END
