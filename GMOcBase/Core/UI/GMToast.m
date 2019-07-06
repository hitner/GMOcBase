//
//  GMToast.m
//  GMOcBase
//
//  Created by liuzhuzhai on 2019/7/6.
//

#import "GMToast.h"

#define GMToastWidth 200.f
#define GMToastHeight 220.f

@interface GMToastView : UIView
@property(nonatomic) NSTimer * timer;
- (void)dismiss;

- (void)replaceWithInfo:(NSString*)info
               duration:(NSTimeInterval)interval
             completion:(GMBlockVoid)block;
@end


@implementation GMToastView

- (void)trigTimer:(NSTimeInterval)interval {
    if (interval > 0) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval repeats:NO block:^(NSTimer * _Nonnull timer) {
            [self.timer invalidate];
            self.timer = nil;
            [self removeWithAnimation];
        }];
    }
}

- (void)dismiss {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self removeWithAnimation];
}

- (void)removeWithAnimation {
    [self removeFromSuperview];
}

- (void)replaceWithInfo:(NSString*)info
               duration:(NSTimeInterval)interval
             completion:(GMBlockVoid)block{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (interval > 0) {
        [self trigTimer:interval];
    }
}
@end


#pragma mark - TipView

@interface GMToastTipView : GMToastView
+ (instancetype)addToWindowWithTip:(NSString*)tip
                  duration:(NSTimeInterval)duration;
@end

@implementation GMToastTipView
+ (instancetype)addToWindowWithTip:(NSString*)tip
                          duration:(NSTimeInterval)duration {
    CGRect frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, 200, 100);
    GMToastView * toastView = [[GMToastView alloc] init];
    toastView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [toastView setInfo:info isLoading:interval == 0];
    [toastView trigTimer:interval];
    return toastView;
}
@end

#pragma mark - WaitingView

@interface GMToastWaitingView : GMToastView
+(instancetype)addToWindowWithInfo:(NSString*)info
                          duration:(NSTimeInterval) interval
                        completion:(GMBlockVoid)block;
@end

@implementation GMToastWaitingView
+(instancetype)addToWindowWithInfo:(NSString*)info
                          duration:(NSTimeInterval) interval
                        completion:(GMBlockVoid)block {
    
}
@end


#pragma mark - GMToast interface
/// must be unique
static GMToastView * __gm_toastView_110 ;

@implementation GMToast

/// 默认两秒
+ (void)tip:(nullable NSString*)info {
    [self tip:info duration:2.0];
}

/// 加在Window上面的视图
+ (void)tip:(nullable NSString*)info
   duration:(NSTimeInterval) interval {
    NSAssert(info && interval > 0, @"toast error parameters");
    if (__gm_toastView_110) {
        if ([__gm_toastView_110 isKindOfClass:[GMToastWaitingView class]]) {
            //waitingView has hight priority
            return;
        }
        else {
            //replace with new text
            [__gm_toastView_110 replaceWithInfo:info
                                       duration:interval
                                     completion:nil];
        }
    }
    else {
        __gm_toastView_110 = [GMToastTipView addToWindowWithTip:info duration:interval];
    }
    
}


/// 无限的Toast，禁止其他操作
+ (void)waitingWithInfo:(nullable NSString*)info {
    [self waitingWithInfo:info duration:0 completion:nil];
}

/// 禁止其它操作，加在Window上面的视图,在dismiss的时候执行回调, interval 为0表示永远
+ (void)waitingWithInfo:(nullable NSString*)info
               duration:(NSTimeInterval) interval
             completion:(nullable GMBlockVoid)block {
    if (__gm_toastView_110) {
        if ([__gm_toastView_110 isKindOfClass:[GMToastTipView class]]) {
            //waitingView has hight priority
            [__gm_toastView_110 dismiss];
        }
        else {
            //replace with new text
            [__gm_toastView_110 replaceWithInfo:info
                                       duration:interval
                                     completion:nil];
            return;
        }
    }
    
    __gm_toastView_110 = [GMToastWaitingView addToWindowWithInfo:info
                                                       duration:interval
                                                      completion:block];
    
}

        



+ (void)dismiss {
    [__gm_toastView_110 dismiss];
    __gm_toastView_110 = nil;
}

@end
