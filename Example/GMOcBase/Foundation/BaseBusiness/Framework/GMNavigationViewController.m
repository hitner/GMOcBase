//
//  GMNavigationViewController.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/11/19.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "GMNavigationViewController.h"
#import "GMMainTabBarController.h"
@interface GMNavigationViewController ()

@end

@implementation GMNavigationViewController

+ (instancetype)sharedObject {
    static dispatch_once_t __once;
    static GMNavigationViewController * __instance = nil;
    dispatch_once(&__once, ^{
        __instance = [[GMNavigationViewController alloc] initWithRootViewController:[GMMainTabBarController sharedController]];
    });
    return __instance;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hidesBarsOnSwipe = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
