//
//  GMURLSessionManager.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/31.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMURLSessionManager : NSObject
DECLARE_SIGNALTON()
/// 回调在mainQueue 的通用session，用于 下载image 、其它data
@property (nonatomic ,readonly)NSURLSession * commonMainQueueSession;
@end

NS_ASSUME_NONNULL_END
