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
 异步设置iconfont,大小是ImageView大小。故必须设置先设置frame!
 */
- (void)setIcon:(NSString*)iconName
       fontFamily:(NSString*)fontFamily
foregroundColor:(UIColor*) iconColor
backgroundColor:(UIColor*) backColor;



/// 异步设置http url的图片(NSString*)
- (void)setImageWithUrlString:(NSString*)url;


/// 有内存缓存的图片，用于多次显示的情况
- (void)setFrequentImageWithUrlString:(NSString *)url;

/// 一般不使用，请用快捷方法
- (void)setImageWithUrlString:(NSString*)url
                 memoryCached:(BOOL)cached;
@end

NS_ASSUME_NONNULL_END
