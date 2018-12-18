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
- (void)doubleClickOnView:(GMFloatableView*)view;
@end


@interface GMFloatableView : UIControl

@property (nonatomic, weak) id<GMFloatableViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
