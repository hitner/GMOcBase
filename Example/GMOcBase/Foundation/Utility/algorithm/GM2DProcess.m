//
//  GM2DProcess.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/18.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "GM2DProcess.h"

@implementation GM2DProcess
+ (BOOL)linearLeastSquares:(const CGPoint *) src
                 transform:(CGAffineTransform ) transform
                     count: (NSInteger) count
                     slope:(CGFloat*)slope
                  constant:(CGFloat*)constant {
    const CGPoint * iter;
    CGPoint trans;
    CGFloat sumx = 0;
    CGFloat sumx2 = 0;
    CGFloat sumxy = 0;
    CGFloat sumy = 0;
    CGFloat sumy2 = 0;
    
    for (NSInteger i = 0; i < count ; i++) {
        iter = src + i;
        
        trans = CGPointApplyAffineTransform(*iter, transform);
        sumx += trans.x;
        sumx2 += (trans.x * trans.x);
        sumy += trans.y;
        sumy2 += (trans.y * trans.y);
        sumxy += (trans.x * trans.y);
    }
    
    CGFloat denom =  sumx2 * count - sumx * sumx;
    if (denom == 0) {
        *constant = sumx/count;
        return NO;
    }
    *slope = (sumxy*count - sumx*sumy)/denom;
    *constant = (sumy*sumx2 - sumx*sumxy)/denom;
    return YES;
}

+ (void)weightPoint:(CGPoint*)weight forPoints:(const CGPoint*)src transform:(CGAffineTransform ) transform
              count: (NSInteger) count {
    const CGPoint * iter;
    CGPoint trans;
    CGFloat sumx = 0;
    CGFloat sumy = 0;
    
    for (NSInteger i = 0; i < count ; i++) {
        iter = src + i;
        trans = CGPointApplyAffineTransform(*iter, transform);
        sumx += trans.x;
        sumy += trans.y;
    }
    
    weight->x = sumx/count;
    weight->y = sumy/count;
    
}

+ (void)size:(CGSize*)size forPoints:(const CGPoint*)src transform:(CGAffineTransform ) transform
       count: (NSInteger) count {
    const CGPoint * iter;
    CGPoint trans;
    CGFloat maxx = -MAXFLOAT;
    CGFloat minx = MAXFLOAT;
    CGFloat maxy = -MAXFLOAT;
    CGFloat miny = MAXFLOAT;
    
    for (NSInteger i = 0; i < count ; i++) {
        iter = src + i;
        trans = CGPointApplyAffineTransform(*iter, transform);
        if (maxx < trans.x) {
            maxx = trans.x;
        }
        if (minx > trans.x) {
            minx = trans.x;
        }
        
        if (maxy < trans.y) {
            maxy = trans.y;
        }
        if (miny > trans.y) {
            miny = trans.y;
        }
   
    }
    
    size->width = maxx-minx;
    size->height = maxy-miny;
}

@end
