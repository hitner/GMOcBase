//
//  LGHoleView.h
//  GMOcBase
//
//  Created by liuzhuzhai on 2018/10/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGHoleView : UIView
- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype) initWithFrame:(CGRect)frame
               backgroundColor:(UIColor*)color
                     holeColor:(UIColor*)holeColor
                rectangleHoles:(NSArray*)rects
                  ellipseHoles:(NSArray*)ellipse;

@property(nonatomic, readonly) UIColor * backgroundColor;
@property(nonatomic, readonly) UIColor * holeColor;
@property(nonatomic, copy, readonly) NSArray * rectangleHoles;
@property(nonatomic, copy, readonly) NSArray * ellipseHoles;
@end

NS_ASSUME_NONNULL_END
