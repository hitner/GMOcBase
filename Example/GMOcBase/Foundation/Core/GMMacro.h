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
__strong __typeof(&*weakSelf)self = weakSelf_gm;

//=================================================================================
//单例
#define DECLARE_SIGNALTON()\
+ (instancetype)sharedObject;

#define IMPLEMENT_SIGNALTON(__TYPE__)       \
    + (instancetype)sharedObject {          \
        static dispatch_once_t __once;      \
        static __TYPE__ * __instance = nil; \
        dispatch_once(&__once, ^{                   \
            __instance = [[__TYPE__ alloc] init];   \
        });                                         \
    return __instance;                          \
}

//高宽比
#define HALF_MINUS(x,y) ((x-y)/2.0)
#define HALF_SUM(x,y) ((x+y)/2.0)


#endif /* GMMacro_h */
