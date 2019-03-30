//
//  GMApperance.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/27.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "GMApperance.h"


@implementation GMApperance

IMPLEMENT_SIGNALTON(GMApperance)

- (instancetype)init {
    self = [super init];
    _primeColor = [UIColor RGB:0xA0522D];
    return self;
}

- (void)initNavigationBarApperance {
    //UIImage * backButtonImage = [UIImage imageNamed:@"Teki"];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage
//                                                      forState:UIControlStateNormal
//                                                    barMetrics:UIBarMetricsDefault];
    //参考自定义文字部分
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin)
 //                                                        forBarMetrics:UIBarMetricsDefault];
}
@end
