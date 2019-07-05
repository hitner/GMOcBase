//
//  UIImageView+GM.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/28.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// -[UIImageView setImage:]是否会cancel掉已有的URL请求
#define GM_SET_IMAGE_CANCEL_URL 0


typedef void(^GMImageCompletionBlock)(UIImage * _Nullable image, NSError * _Nullable error, NSURL * _Nullable imageURL);

@interface UIImageView (GM)

/**
 异步设置iconfont,大小是ImageView大小。故必须设置先设置frame!
 */
- (void)setIcon:(NSString*)iconName
     fontFamily:(NSString*)fontFamily
foregroundColor:(UIColor*) iconColor
backgroundColor:(UIColor*) backColor;



/// 异步设置http url的图片(NSString*)
- (void)gm_setImageWithURL:(NSURL*)url;


- (void)gm_setImageWithURL:(NSURL*)url
          placeholderImage:(nullable UIImage*)image;


- (void)gm_setImageWithURL:(NSURL*)url
          placeholderImage:(nullable UIImage*)image
           completionBlock:(nullable GMImageCompletionBlock) block;


- (void)gm_cancelSetURLImage;

/// 会cancel已有的URL请求
- (void)gm_setImage:(nullable UIImage*)image;

@end

NS_ASSUME_NONNULL_END
