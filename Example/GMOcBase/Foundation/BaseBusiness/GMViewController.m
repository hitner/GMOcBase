//
//  GMViewController.m
//  GMOcBase
//
//  Created by hitner on 10/16/2018.
//  Copyright (c) 2018 hitner. All rights reserved.
//

#import "GMViewController.h"

#import "LGHoleView.h"
#import "GMHttpManager.h"


@interface GMViewController ()

@end

@implementation GMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    LGHoleView * view = [[LGHoleView alloc] initWithFrame:CGRectMake(20, 20, 300, 400)
                                          backgroundColor:[UIColor redColor]
                                                holeColor:[UIColor clearColor]
                                           rectangleHoles:@[[NSValue valueWithCGRect:CGRectMake(0, 0, 20, 30)]]
                                             ellipseHoles:@[[NSValue valueWithCGRect:CGRectMake(100, 100, 40, 20)]]];
    [self.view addSubview:view];
    
    //[[GMHttpManager sharedManager].mainHost getWithPath:]
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
