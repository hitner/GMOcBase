//
//  UIImageView+GM.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/28.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (GM)

/**
 设置iconfont,大小是ImageView大小。
 will set in async
 */
- (void)setIcon:(NSString*)iconName
       fontFile:(NSString*)fontFamily
foregroundColor:(UIColor*) iconColor
backgroundColor:(UIColor*) backColor;


/// 设置http url的图片(NSString*)
- (void)setImageWithUrlString:(NSString*)url;
@end

NS_ASSUME_NONNULL_END
