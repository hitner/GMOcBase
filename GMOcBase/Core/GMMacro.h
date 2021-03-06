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



#pragma mark - 相对于父view获得frame

///相对于bounds的布局
#define GMCenterFrame(superBounds, width, height) \
CGRectMake(CGRectGetMinX(superBounds)+(CGRectGetWidth(superBounds)-width)/2.0, \
CGRectGetMinY(superBounds)+(CGRectGetHeight(superBounds) - height)/2.0, width, height)

#define GMHorizontalCenterFrame(superBounds, y, width, height) \
CGRectMake(CGRectGetMinX(superBounds)+(CGRectGetWidth(superBounds)-width)/2.0, \
y, width, height)

#define GMVerticalCenterFrame(superBounds, x, width, height) \
CGRectMake(x,CGRectGetMinY(superBounds)+(CGRectGetHeight(superBounds) - height)/2.0, width, height)

#define GMMarginBottomSubviewFrame(superBounds, x, marginBottom, width, height) \
CGRectMake(x,CGRectGetMaxY(superBounds)-marginBottom-height, width, height)
#pragma mark - 相对于兄弟view获得frame

///右边，顶部对齐
#define GMRightAlignTopFrame(leftFrame,leftMargin,width,height) \
CGRectMake(CGRectGetMaxX(leftFrame)+leftMargin, CGRectGetMinY(leftFrame), width, height)
///右边，底部对齐
#define GMRightAlignBottomFrame(leftFrame,leftMargin,width,height) \
CGRectMake(CGRectGetMaxX(leftFrame)+leftMargin, \
CGRectGetMaxY(leftFrame) - height, width, height)
///右边，中间对齐
#define GMRightAlignCenterFrame(leftFrame,leftMargin,width,height) \
CGRectMake(CGRectGetMaxX(leftFrame)+leftMargin,\
CGRectGetMinY(leftFrame) + (CGRectGetHeight(leftFrame) - height)/2.0, width, height)

///下边，左对齐
#define GMBottomAlignLeftFrame(topFrame,topMargin,width,height) \
CGRectMake(CGRectGetMinX(topFrame), CGRectGetMaxY(topFrame) + topMargin, width, height)
///下边，中间对齐
#define GMBottomAlignCenterFrame(topFrame,topMargin,width,height) \
CGRectMake(CGRectGetMinX(topFrame)+(CGRectGetWidth(topFrame) - width)/2.0, CGRectGetMaxY(topFrame) + topMargin, width, height)
///下边，右对齐
#define GMBottomAlignRightFrame(topFrame,topMargin,width,height) \
CGRectMake(CGRectGetMinY(topFrame) - width, CGRectGetMaxY(topFrame) + topMargin, width, height)

///屏幕右边沿
#define GMScreenRightEdgeFrame(rightMargin,y,width,height) \
CGRectMake([APP_PROFILE screenWidth] - width - rightMargin, y, width, height)

///左边，顶部对齐
#define GMLeftAlignTopFrame(rightFrame,rightMargin,width,height) \
CGRectMake(CGRectGetMinX(rightFrame)-rightMargin-width, CGRectGetMinY(leftFrame), width, height)
///左边，底部对齐
#define GMLeftAlignBottomFrame(rightFrame,rightMargin,width,height) \
CGRectMake(CGRectGetMinX(rightFrame)-rightMargin-width, CGRectGetMaxY(leftFrame) -height, width, height)
///左边的frame,中心对齐
#define GMLeftAlignCenterFrame(rightFrame,rightMargin,width,height) \
CGRectMake(CGRectGetMinX(rightFrame)-rightMargin-width, CGRectGetMinY(leftFrame)+(CGRectGetHeight(leftFrame) - height)/2.0, width, height)

#pragma mark - block typedef

#ifdef __OBJC__

typedef void(^GMBlockVoid)(void);
typedef void(^GMBlockBool)(BOOL param);
typedef void(^GMBlockInteger)(NSInteger param);
typedef void(^GMBlockId)(id param);

#import "GMLog.h"
#endif


#endif /* GMMacro_h */
