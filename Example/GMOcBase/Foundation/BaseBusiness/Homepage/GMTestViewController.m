//
//  GMTestViewController.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/10/18.
//  Copyright © 2018年 hitner. All rights reserved.
//

#import "GMTestViewController.h"

//VC
#import "GMMainTabBarController.h"
#import "GMFaceTrackViewController.h"
//core
#import "UIViewController+GM.h"
#import "UIAlertController+GM.h"
#import "GMCore.h"
//App
#import "GMPrimeButton.h"
#import "UIButton+App.h"
#import "UIImageView+App.h"
#import "UIImage+App.h"
#import "GMIcons.h"

#import "GMAVUtility.h"


#import "GMSceneExampleViewController.h"

@interface GMTestViewController ()
@property (nonatomic,weak) UIImageView * testImageView;
@end

@implementation GMTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    GMPrimeButton * button = [[GMPrimeButton alloc] initWithFrame:CGRectMake(0, 200, 100, 44)];
    [button setTitle:@"LOGIN" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton * b1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [b1 setTitle:@"KKKKKKj" forState:UIControlStateNormal];
    b1.backgroundColor = [UIColor yellowColor];
    b1.tintColor = [UIColor blackColor];
    b1.frame = CGRectMake(0, 250, 100, 44);
    [self.view addSubview:b1];
    
    UIButton  * b2  = [UIButton primeButtonWithFrame:CGRectMake(10, 300, 100, 44) title:@"ksjdf"];
    [self.view addSubview:b2];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 24, 24)];
    [self.view addSubview:imageView];
    
    UIImage * image = [UIImage imageWithIcon:kIconFontKaraokeHasLyric foregroundColor:[UIColor redColor] backgroundColor:[UIColor yellowColor] size:24.f];
    imageView.image = image;
    
    
    CGRect frame2 = GMBottomAlignCenterFrame(imageView.frame, 20, 140,140);
    UIImageView * imageView2 = [[UIImageView alloc] initWithFrame:frame2];
    self.testImageView = imageView2;
    [self.view addSubview:imageView2];
    
    UILabel * label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor blueColor];
    label.text = @"你师父加，可视对讲拉收快递费，水电费";
    [self.view addSubview:label];
    [label constraintToSuperBottomMargin:20 xAlign:GMAlignAnchorLeft alignMargin:20 width:220 height:40];
    
    UILabel * label2 = [[UILabel alloc] init];
    label2.backgroundColor = [UIColor greenColor];
    label2.text = @"你师父加，可视对讲拉收快递费，水电费";
    [self.view addSubview:label2];
    [label2 constraintToBottomView:label bottomMargin:10 xAxis:50 width:200 height:40];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view Did appear");
    [super viewDidAppear:animated];
}


- (IBAction)touchUpInsideFaceTrack:(id)sender {
    [GMAVUtility requestVideoAuthorization:@"" completionHandler:^{
                        GMFaceTrackViewController * vc = [[GMFaceTrackViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (IBAction)touchUpInside3DScene:(id)sender {
    GMSceneExampleViewController * scene = [[GMSceneExampleViewController alloc] init];
    [self.navigationController pushViewController:scene animated:YES];
    
}




- (IBAction)touchUpInsideButton:(id)sender {
//    UIImage * image = [UIImage imageNamed:@"lizhi"];
//    [self.testImageView gm_setImageWithURL:[NSURL URLWithString:@"https://cdnimg103.lizhi.fm/user/2018/07/06/2679250850695235586.jpg"] placeholderImage:image];
    
//    UIAlertController * alert = [UIAlertController alertControllerWithContent:@"你尚未登录"];
    UIAlertController * alert = [UIAlertController actionSheetControllerWithTitle:@"你还是看得见开始卡三等奖，可是大家？" content:nil cancelText:nil cancelAction:nil changeText:nil changeAction:nil];
    [self presentViewController:alert animated:YES completion:nil];
}


- (IBAction)touchUpInsideGcdButton:(id)sender {
    UIImage * image = [UIImage imageNamed:@"lizhi_logo"];
    //[self.testImageView gm_setImageWithURL:[NSURL URLWithString:@"https://cdnimg103.lizhi.fm/user/2018/07/06/2679250850695235586.jpg"] placeholderImage:image];
    [self.testImageView gm_setImageWithURL:[NSURL URLWithString:@"https://cdn.lizhi.fm/studio/2019/06/10/2742105951893607990.jpg"]];
    //[self.testImageView gm_setImage:image];
}

@end
