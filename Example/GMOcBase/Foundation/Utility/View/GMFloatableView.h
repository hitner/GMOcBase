//
//  GMFloatableView.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/14.
//  Copyright © 2018 hitner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GMFloatableView;

@protocol GMFloatableViewDelegate <NSObject>

@optional
- (void)didTouchUpInsideFloatableView:(GMFloatableView*)view;

@end


@interface GMFloatableView : UIView

@property (nonatomic, weak) id<GMFloatableViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

+ (void)enableFloatableToView:(UIView*)view delegate:(id<GMFloatableViewDelegate>) delegate;

@end

NS_ASSUME_NONNULL_END
