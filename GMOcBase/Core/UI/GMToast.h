//
//  GMToast.h
//  GMOcBase
//
//  Created by liuzhuzhai on 2019/7/6.
//

#import <Foundation/Foundation.h>
#import "GMMacro.h"
NS_ASSUME_NONNULL_BEGIN

@interface GMToast : NSObject

/// 默认两秒
+ (void)tip:(nullable NSString*)info;

/// 加在Window上面的视图
+ (void)tip:(nullable NSString*)info
   duration:(NSTimeInterval) interval;


/// 无限的Toast，禁止其他操作
+ (void)waitingWithInfo:(nullable NSString*)info;

/// 禁止其它操作，加在Window上面的视图,在dismiss的时候执行回调, interval 为0表示永远,block YES表示手动dismiss,NO表示超时产生
+ (void)waitingWithInfo:(nullable NSString*)info
               duration:(NSTimeInterval) interval
             completion:(nullable GMBlockBool)block;

+ (void)dismiss;
@end

NS_ASSUME_NONNULL_END
