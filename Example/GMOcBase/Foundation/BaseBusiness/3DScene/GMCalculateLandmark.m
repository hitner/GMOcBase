//
//  GMCalculateLandmark.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2019/1/15.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "GMCalculateLandmark.h"

#define EYE_OPEN_INC (0.2)
#define EYE_CLOSE_INC (-0.3)

#define EYE_K (1.0/(EYE_OPEN_INC - EYE_CLOSE_INC))
#define EYE_COSTANT (1.0 - EYE_K * EYE_OPEN_INC)

@interface GMCalculateLandmark()
@property(nonatomic) NSUInteger count;
@property(nonatomic) CGFloat eyeSumRaito;

@end



@implementation GMCalculateLandmark

- (instancetype)init {
    self = [super init];
    self.count = 0;
    self.eyeSumRaito = 0;
    return self;
}

/*
 * 以鼻子为中心的头的旋转角度值
 */
- (CGFloat) slopeForPoint:(const CGPoint *) src
                transform:(CGAffineTransform ) transform
                    count: (NSInteger) count
                    slope:(CGFloat*)slope
                 constant:(CGFloat*)constant {
    static CGFloat lastSlope = 0;
    CGPoint start = CGPointApplyAffineTransform(src[0], transform);
    CGPoint end = CGPointApplyAffineTransform(src[count - 1], transform);
    
    if (start.x == end.x) {
        *constant = start.x;
        lastSlope = 0;
        return 0;
    }
    
    *slope = (start.y - end.y)/(start.x - end.x);
    *constant = start.y - start.x * (*slope);
    CGFloat leftRightSlope;
    if (*slope > 0) {
        leftRightSlope = - (M_PI_2 - atanf(*slope));
    }
    else {
        leftRightSlope = M_PI_2 + atanf(*slope);
    }
    leftRightSlope = (lastSlope + 3 * leftRightSlope)/4;
    lastSlope = leftRightSlope;
    
    return leftRightSlope;
}


/*
 * 左右旋转角度
 */
- (CGFloat) rotoateForPoint:(const CGPoint *) src
                  transform:(CGAffineTransform ) transform
                      count: (NSInteger) count {
    
    return 0;
    
    
}


- (CGFloat) eyeOpeningForPoint:(const CGPoint *) src
                     transform:(CGAffineTransform ) transform
                         count: (NSInteger) count {
    NSAssert(count == 8, @"must 8 point");
    CGPoint left = CGPointApplyAffineTransform(src[0], transform);
    CGPoint right = CGPointApplyAffineTransform(src[4], transform);
    CGPoint top = CGPointApplyAffineTransform(src[2], transform);
    CGPoint bottom = CGPointApplyAffineTransform(src[6], transform);
    
    CGFloat width = hypotf(right.x - left.x, right.y - left.y);
    CGFloat height = hypotf(top.x - bottom.x, top.y - bottom.y);
    CGFloat ratio = height/width;
    
    if (self.count < LONG_MAX -10) {
        self.count = self.count + 1;
        _eyeSumRaito += ratio;
    }
    CGFloat averageRatio = _eyeSumRaito/self.count;
    
    CGFloat incRatio = (ratio - averageRatio)/averageRatio;
    CGFloat finalValue = [self eyeOpeningFromIncRatio:incRatio];
    
    NSLog(@"inc ratio:%@, final Value:%@",@(incRatio), @(finalValue));
    
    return finalValue;
}

- (CGFloat) eyeOpeningFromIncRatio:(CGFloat)incRatio {
    if (incRatio >= EYE_OPEN_INC) {
        return 1.0;
    }
    else if (incRatio <= EYE_CLOSE_INC) {
        return 0;
    }
    else {
        return EYE_K*incRatio+EYE_COSTANT;
    }
}

@end
