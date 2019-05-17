//
//  GMUrlRouter.h
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/4/26.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * 只做
 */
@interface GMUrlRouter : NSObject
DECLARE_SIGNALTON()

- (void)registerUrlKey:(NSString*)key viewControllerClass:(Class)vcClass;

- (BOOL)navigateToUrl:(NSString*)url;



@end

NS_ASSUME_NONNULL_END
