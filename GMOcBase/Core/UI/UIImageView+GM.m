//
//  UIImageView+GM.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/28.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "UIImageView+GM.h"
#import "UIImage+GM.h"
#import "GMHttpManager.h"
#import "GMEnum.h"
#import <objc/runtime.h>

const char * kImageViewAssociatedURLTask = "_kImageAssociatedUrl";

@implementation UIImageView (GM)

+ (void)initialize
{
    
}


- (void)setIcon:(NSString*)iconName
     fontFamily:(NSString*)fileName
foregroundColor:(UIColor*) iconColor
backgroundColor:(UIColor*) backColor
{
    CGFloat size = MIN(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    weakifySelf
    [UIImage imageWithIcon:iconName
           foregroundColor:iconColor
           backgroundColor:backColor
                      font:[UIFont fontWithName:fileName size:size]
                    result:^(UIImage * _Nonnull image) {
                        strongifySelfReturnIfNil
        self.image = image;
    }];
}


/// 异步设置http url的图片(NSString*)
- (void)gm_setImageWithURL:(NSURL*)url {
    [self gm_setImageWithURL:url placeholderImage:nil completionBlock:nil];
}


- (void)gm_setImageWithURL:(NSURL*)url
          placeholderImage:(nullable UIImage*)image {
     [self gm_setImageWithURL:url placeholderImage:image completionBlock:nil];
}


- (void)gm_setImageWithURL:(NSURL*)url
          placeholderImage:(nullable UIImage*)image
           completionBlock:(nullable GMImageCompletionBlock) block {
    NSAssert(url,@"need a nonnull url");
    if (!url) {
        return;
    }
    
    NSURLSessionDataTask * associatedTask = objc_getAssociatedObject(self, kImageViewAssociatedURLTask);
    if (associatedTask) {
        if ([url isEqual:associatedTask.originalRequest.URL]) {
            return;
        }
        else {
            if (associatedTask.state == NSURLSessionTaskStateRunning ||
                associatedTask.state == NSURLSessionTaskStateSuspended) {
                [associatedTask cancel];
            }
        }
    }
    
    weakifySelf
    NSURLSessionDataTask * dataTask = [UIImage imageWithURL:url result:^(UIImage * _Nonnull image, NSError * _Nonnull error) {
        strongifySelfReturnIfNil
        NSURLSessionDataTask * origTask = objc_getAssociatedObject(self, kImageViewAssociatedURLTask);
        NSString * failedReason = @"task not exist,may be cancelled";
        if (origTask) {
            if ([url isEqual:origTask.originalRequest.URL]) {
                if (image && !error) {
                    [self setImage:image];
                }
                if (block) {
                    block(image,error,url);
                }
                return;
            }
            else {
                failedReason = @"url not equal,may be replaced";
            }
        }
        if (block) {
            block(nil,[NSError errorWithDomain:GMImageViewURLError code:901 userInfo:@{NSLocalizedFailureReasonErrorKey:failedReason}], url);
        }
        
    }];
    objc_setAssociatedObject(self, kImageViewAssociatedURLTask, dataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)gm_cancelSetURLImage {
    NSURLSessionDataTask * associatedTask = objc_getAssociatedObject(self, kImageViewAssociatedURLTask);
    if (associatedTask) {
        if (associatedTask.state == NSURLSessionTaskStateRunning ||
                associatedTask.state == NSURLSessionTaskStateSuspended) {
            [associatedTask cancel];
            objc_setAssociatedObject(self, kImageViewAssociatedURLTask, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

/// 会cancel已有的URL请求
- (void)gm_setImage:(nullable UIImage*)image {
    [self gm_cancelSetURLImage];
    [self setImage:image];
}

@end
