//
//  GMCalculateLandmark.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2019/1/15.
//  Copyright © 2019 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMCalculateLandmark : NSObject

/*
 * 以鼻子为中心的头的旋转角度值
 */
- (CGFloat) slopeForPoint:(const CGPoint *) src
                    transform:(CGAffineTransform ) transform
                        count: (NSInteger) count
                        slope:(CGFloat*)slope
                     constant:(CGFloat*)constant;

/*
 * 左右旋转角度
 */
- (CGFloat) rotoateForPoint:(const CGPoint *) src
                  transform:(CGAffineTransform ) transform
                      count: (NSInteger) count;

/*
 * 返回0-1的数，1表示完全睁开
 */
- (CGFloat) eyeOpeningForPoint:(const CGPoint *) src
                     transform:(CGAffineTransform ) transform
                         count: (NSInteger) count;

@end

NS_ASSUME_NONNULL_END
