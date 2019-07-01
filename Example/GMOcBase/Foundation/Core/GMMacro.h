//
//  GMMacro.h
//  GMOcBase
//
//  Created by liuzhuzhai on 2018/11/19.
//  Copyright © 2018 hitner. All rights reserved.
//

#ifndef GMMacro_h
#define GMMacro_h


//定义了一个__weak的self_weak_变量
#define weakifySelf  \
__weak __typeof(&*self)weakSelf_gm = self;

//局域定义了一个__strong的self指针指向self_weak
#define strongifySelf \
__strong __typeof(&*weakSelf_gm)self = weakSelf_gm;

#define strongifySelfReturnIfNil strongifySelf \
if(!self) { return;}

//=================================================================================
//单例
#define DECLARE_SIGNALTON()\
+ (instancetype)sharedObject;

#define IMPLEMENT_SIGNALTON()\
    + (instancetype)sharedObject {           \
        static dispatch_once_t __once;       \
        static id __instance = nil;  \
        dispatch_once(&__once, ^{            \
            __instance = [[self alloc] init];\
        });                                  \
    return __instance;                       \
}

///差值的二分之一
#define HALF_MINUS(x,y) ((x-y)/2.0)
///和值得二分之一
#define HALF_SUM(x,y) ((x+y)/2.0)

//LOG 部分

#define GMLogDebug(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#define GMLogInfo(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#define GMLogWarn(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#define GMLogError(fmt, ...) NSLog(fmt, ##__VA_ARGS__)


#pragma mark - UI view part

#define GMRightAnchorTopFrame(leftFrame,leftMargin,width,height) \
CGRectMake(CGRectGetMaxX(leftFrame)+leftMargin, CGRectGetMinY(leftFrame), width, height)

#define GMRightAnchorBottomFrame(leftFrame,leftMargin,width,height) \
CGRectMake(CGRectGetMaxX(leftFrame)+leftMargin, \
CGRectGetMinY(leftFrame) + (CGRectGetHeight(self.frame) - height)/2.0, width, height)

#define GMRightAnchorCenterFrame(leftFrame,leftMargin,width,height) \
CGRectMake(CGRectGetMaxX(leftFrame)+leftMargin, CGRectGetMinY(leftFrame), width, height)


#endif /* GMMacro_h */
