//
//  GMFormatterVendor.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/4/9.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMFormatterVendor : NSObject
DECLARE_SIGNALTON()
/// 2019-02-21 23:12:01 的形式
@property (nonatomic, readonly) NSDateFormatter * normalDateFormatter;
@end

NS_ASSUME_NONNULL_END
