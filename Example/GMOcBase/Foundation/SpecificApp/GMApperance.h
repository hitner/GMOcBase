//
//  GMApperance.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/27.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMApperance : NSObject

DECLARE_SIGNALTON()

- (void)initNavigationBarApperance;

@property(nonatomic, readonly) UIColor * primeColor;
@end

NS_ASSUME_NONNULL_END
