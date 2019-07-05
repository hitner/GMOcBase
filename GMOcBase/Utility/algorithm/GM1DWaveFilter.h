//
//  GM1DWaveFilter.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/19.
//  Copyright © 2018 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GM1DWaveFilter : NSObject
@property(nonatomic, readonly) NSArray* filter;
@property(nonatomic, readonly) NSInteger origin;
@property(nonatomic, readonly) NSInteger inputCount;

- (instancetype)initWithFilter:(NSArray<NSNumber*>*)filter origin:(NSInteger)origin;

- (CGFloat)processInput:(CGFloat)next;
@end

NS_ASSUME_NONNULL_END
