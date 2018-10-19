//
//  GMMainTabBarController.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/10/17.
//  Copyright © 2018年 hitner. All rights reserved.
//

#import "GMMainTabBarController.h"
#import "GMTestViewController.h"

@interface GMMainTabBarController ()

@end

@implementation GMMainTabBarController

+ (instancetype)sharedController{
    static GMMainTabBarController *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    UIViewController * vc1 = [[GMTestViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    UIViewController * vc2 = [[UIViewController alloc] init];
    UIViewController * vc3 = [[UIViewController alloc] init];
    UINavigationController * navi1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    navi1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:nil selectedImage:nil];
    UINavigationController * navi2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    navi2.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemContacts tag:1];
    UINavigationController * navi3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    self.viewControllers = @[navi1, navi2, navi3];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
