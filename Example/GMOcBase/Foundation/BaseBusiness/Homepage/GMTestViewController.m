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
#import "GMToast.h"
//App
#import "GMPrimeButton.h"
#import "UIButton+App.h"
#import "UIImageView+App.h"
#import "UIImage+App.h"
#import "GMIcons.h"

#import "GMAVUtility.h"

#import "GMWarmUp.h"

#import "GMSceneExampleViewController.h"

#import "GMWebViewController.h"

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
    
    
    
    UIView * shadowView = [[UIView alloc ] initWithFrame:CGRectMake(30, 440, 60, 60)];
    shadowView.backgroundColor = [UIColor brownColor];
    shadowView.layer.shadowOpacity = 1.0;
    shadowView.layer.shadowColor = [UIColor redColor].CGColor;
    shadowView.layer.shadowRadius = 0.f;
    shadowView.layer.shadowOffset = CGSizeMake(0, 10);
    CGRect shadowRect = CGRectInset(shadowView.bounds, 0, 10);  // inset top/bottom
    //shadowView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:shadowRect] CGPath];
    shadowView.layer.shadowPath = CGPathCreateWithRect(CGRectMake(0, 60, 60, 5), NULL);
    [self.view addSubview:shadowView];
}

- (void)viewDidAppear:(BOOL)animated {

        CGFloat bottom;
        if(@available(iOS 11.0, *)) {
            bottom = [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom;
            CGFloat top = [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.top;
        }
        else {bottom = 0;}


    CGFloat bottom2 = self.view.safeAreaInsets.bottom;
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




- (IBAction)touchUpInsideButton:(UIButton*)sender {
//    UIImage * image = [UIImage imageNamed:@"lizhi"];
//    [self.testImageView gm_setImageWithURL:[NSURL URLWithString:@"https://cdnimg103.lizhi.fm/user/2018/07/06/2679250850695235586.jpg"] placeholderImage:image];
    
//    UIAlertController * alert = [UIAlertController alertControllerWithContent:@"你尚未登录"];
//    UIAlertController * alert = [UIAlertController actionSheetControllerWithTitle:@"你还是看得见开始卡三等奖，可是大家？" content:nil cancelText:nil cancelAction:nil changeText:nil changeAction:nil];
//    [self presentViewController:alert animated:YES completion:nil];
    //[GMToast tip:@"kkkkkk"];
    //[GMToast waitingWithInfo:@"锆石似的几十块的"];
    if ([sender.currentTitle isEqualToString:@"WarmUp"]) {
        [[GMWarmUp sharedObject] warmUp];
        [sender setTitle:@"StopWarm" forState:UIControlStateNormal];
    }
    else {
        [[GMWarmUp sharedObject] stopWarm];
        [sender setTitle:@"WarmUp" forState:UIControlStateNormal];
    }
}


- (IBAction)touchUpInsideGcdButton:(id)sender {
    UIImage * image = [UIImage imageNamed:@"lizhi_logo"];
    //[self.testImageView gm_setImageWithURL:[NSURL URLWithString:@"https://cdnimg103.lizhi.fm/user/2018/07/06/2679250850695235586.jpg"] placeholderImage:image];
    [self.testImageView gm_setImageWithURL:[NSURL URLWithString:@"https://cdn.lizhi.fm/studio/2019/06/10/2742105951893607990.jpg"]];
    //[self.testImageView gm_setImage:image];
}
- (IBAction)touchUpInsideWebView:(id)sender {
    GMWebViewController * webVC = [[GMWebViewController alloc] initWithWebURL:[NSURL URLWithString:@"https://liveamuactivity.lizhifm.com/static/game-center/index.html?alert=1"]];
    [self.navigationController pushViewController:webVC animated:YES];
    
}

@end
