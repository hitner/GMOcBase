//
//  GMAppProfile.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2019/3/20.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMAppProfile : NSObject
@property (nonatomic,readonly) BOOL isIphoneXSerial;
DECLARE_SIGNALTON()
@end

NS_ASSUME_NONNULL_END
