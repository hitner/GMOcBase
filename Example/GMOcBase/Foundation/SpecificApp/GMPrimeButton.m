//
//  GMPrimeButton.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/3/29.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "GMPrimeButton.h"
#import "GMApperance.h"

@implementation GMPrimeButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initPrimeButton];
    }
    return self;
}

- (void)initPrimeButton {
    self.backgroundColor = [GMApperance sharedObject].primeColor;
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.layer.cornerRadius = 4.0;
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = [UIColor greenColor];
    }
    else {
        self.backgroundColor = [GMApperance sharedObject].primeColor;
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        self.backgroundColor = [GMApperance sharedObject].primeColor;
    }
    else {
        self.backgroundColor = [UIColor grayColor];
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self initPrimeButton];
    return self;
}


@end
