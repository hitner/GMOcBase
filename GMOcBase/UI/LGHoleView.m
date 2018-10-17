//
//  LGHoleView.m
//  GMOcBase
//
//  Created by liuzhuzhai on 2018/10/17.
//

#import "LGHoleView.h"

@interface LGHoleView()
@property (nonatomic) UIColor * fillColor;

@end

@implementation LGHoleView

- (instancetype) initWithFrame:(CGRect)frame
               backgroundColor:(UIColor*)color
                     holeColor:(UIColor*)holeColor
                rectangleHoles:(NSArray*)rects
                  ellipseHoles:(NSArray*)ellipse {
    self = [super initWithFrame:frame];
    self.fillColor = color;
    _holeColor = holeColor;
    _rectangleHoles = rects;
    _ellipseHoles = ellipse;
    self.opaque = NO;
    return self;
}

- (UIColor*)backgroundColor {
    return _fillColor;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.fillColor setFill];
    UIRectFill(rect);
    
    // clear the background in the given rectangles
    for (NSValue *holeRectValue in self.rectangleHoles) {
        CGRect holeRect = [holeRectValue CGRectValue];
        CGRect holeRectIntersection = CGRectIntersection( holeRect, rect );
        [self.holeColor setFill];
        UIRectFill(holeRectIntersection);
    }
    
    for (NSValue *holeRectValue in self.ellipseHoles) {
        CGRect holeRect = [holeRectValue CGRectValue];
        CGRect holeRectIntersection = CGRectIntersection( holeRect, rect );
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        if( CGRectIntersectsRect( holeRectIntersection, rect ) )
        {
            CGContextAddEllipseInRect(context, holeRectIntersection);
            CGContextClip(context);
            CGContextClearRect(context, holeRectIntersection);
            CGContextSetFillColorWithColor( context, self.holeColor.CGColor);
            CGContextFillRect( context, holeRectIntersection);
        }
    }
}



@end
