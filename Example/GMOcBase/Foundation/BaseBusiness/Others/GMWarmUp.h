//
//  GMWarmUp.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/9/30.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMWarmUp : NSObject

DECLARE_SIGNALTON()

- (void)warmUp;

- (void)stopWarm;
@end

NS_ASSUME_NONNULL_END
