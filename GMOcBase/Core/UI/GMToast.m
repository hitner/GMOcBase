//
//  GMToast.m
//  GMOcBase
//
//  Created by liuzhuzhai on 2019/7/6.
//

#import "GMToast.h"



@interface GMToastView : UIView
@property(nonatomic) NSTimer * timer;
@property(nonatomic) GMBlockBool autoDismissBlock;
- (void)dismiss;

- (void)replaceWithInfo:(NSString*)info
               duration:(NSTimeInterval)interval
             completion:(GMBlockBool)block;

- (void)autoTimeoutForTimer:(NSTimer*)timer;
@end

/// must be unique
static GMToastView * __gm_toastView_110 ;

@implementation GMToastView

- (void)autoTimeoutForTimer:(NSTimer *)timer {
    [self.timer invalidate];
    self.timer = nil;
    [self removeWithAnimation];
    __gm_toastView_110 = nil;
}

- (void)trigTimer:(NSTimeInterval)interval {
    if (interval > 0) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(autoTimeoutForTimer:) userInfo:nil repeats:NO];
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
             completion:(GMBlockBool)block{
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

#define GMToastWidth 200.f
#define GMToastHeight 220.f
@interface GMToastTipView : GMToastView
+ (instancetype)addToWindowWithTip:(NSString*)tip
                  duration:(NSTimeInterval)duration;
@property(nonatomic) UILabel * label;
@end

@implementation GMToastTipView

+ (instancetype)addToWindowWithTip:(NSString*)tip
                          duration:(NSTimeInterval)duration {
    UIView* superView = [UIApplication sharedApplication].delegate.window;
    CGRect frame = GMCenterFrame(superView.bounds,GMToastWidth,GMToastHeight);
    GMToastTipView * toastView = [[GMToastTipView alloc] initWithFrame:frame];
    [toastView trigTimer:duration];
    [toastView.label setText:tip];
    [toastView.label sizeToFit];
    [superView addSubview:toastView];
    return toastView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.userInteractionEnabled = NO;
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.textColor = [UIColor whiteColor];
    self.label = label;
    [self addSubview:label];
    return self;
}
@end

#pragma mark - WaitingView

@interface GMToastWaitingView : GMToastView
@property (nonatomic) UILabel * label;
@property (nonatomic) UIActivityIndicatorView * indicatorView;
@property (nonatomic) GMBlockBool completionBlock;
+(instancetype)addToWindowWithInfo:(NSString*)info
                          duration:(NSTimeInterval) interval
                        completion:(GMBlockBool)block;
@end

@implementation GMToastWaitingView

+(instancetype)addToWindowWithInfo:(NSString*)info
                          duration:(NSTimeInterval) duration
                        completion:(GMBlockBool)block {
    UIView* superView = [UIApplication sharedApplication].delegate.window;
    GMToastWaitingView * waitingView = [[GMToastWaitingView alloc] initWithFrame:superView.bounds];
    [waitingView trigTimer:duration];
    [waitingView.label setText:info];
    waitingView.completionBlock = block;
    
    [superView addSubview:waitingView];
    return waitingView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    
    CGRect containerframe = GMCenterFrame(self.bounds,GMToastWidth,GMToastHeight);
    UIView * containerView = [[UIView alloc] initWithFrame:containerframe];
    containerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [self addSubview:containerView];
    
    UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.frame = GMHorizontalCenterFrame(containerView.bounds, 30, CGRectGetWidth(indicatorView.frame), CGRectGetHeight(indicatorView.frame));
    [containerView addSubview:indicatorView];
    [indicatorView startAnimating];
    self.indicatorView = indicatorView;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(indicatorView.frame) + 30, GMToastWidth, 30)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.label = label;
    [containerView addSubview:label];
    return self;
}


- (void)autoTimeoutForTimer:(NSTimer *)timer {
    GMBlockBool block =  self.completionBlock;
    [self.indicatorView stopAnimating];
    [super autoTimeoutForTimer:timer];
    if (block) {
        block(NO);
    }
}
@end


#pragma mark - GMToast interface


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
             completion:(nullable GMBlockBool)block {
    if (__gm_toastView_110) {
        if ([__gm_toastView_110 isKindOfClass:[GMToastTipView class]]) {
            //waitingView has hight priority
            [__gm_toastView_110 dismiss];
        }
        else {
            //replace with new text
            [__gm_toastView_110 replaceWithInfo:info
                                       duration:interval
                                     completion:block];
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
