//
//  GMSceneExampleViewController.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/11/21.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "GMSceneExampleViewController.h"

@import SceneKit;

@interface GMSceneExampleViewController ()

@end

@implementation GMSceneExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SCNView * scnView = [[SCNView alloc] initWithFrame:CGRectMake(0, 60, 300, 400) options:nil];
    [scnView setScene:[SCNScene sceneNamed:@"3DDog"]];
    [self.view addSubview:scnView];
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
