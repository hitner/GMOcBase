//
//  GM2DProcess.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/18.
//  Copyright © 2018 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GM2DProcess : NSObject

+ (BOOL)linearLeastSquares:(const CGPoint *) src
                 transform:(CGAffineTransform ) transform
                        count: (NSInteger) count
                     slope:(CGFloat*)slope
                  constant:(CGFloat*)constant;

+ (void)weightPoint:(CGPoint*)weight forPoints:(const CGPoint*)src transform:(CGAffineTransform ) transform
              count: (NSInteger) count;

+ (void)size:(CGSize*)size forPoints:(const CGPoint*)src transform:(CGAffineTransform ) transform
       count: (NSInteger) count;
@end

NS_ASSUME_NONNULL_END
