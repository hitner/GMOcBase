//
//  GMDebugControlView.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/17.
//  Copyright © 2018 hitner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMDebugControlViewDelegate <NSObject>

@optional


@end


@interface GMDebugControlView : UIView
@property(nonatomic, weak)id<GMDebugControlViewDelegate> delegate;
@property(nonatomic, copy)NSArray * dataSource;
@end

NS_ASSUME_NONNULL_END
