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
    [imageView2 gm_setImageWithURL:[NSURL URLWithString:@"https://cdnimg103.lizhi.fm/user/2018/07/06/2679250850695235586.jpg"]];
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
//    NSMutableArray * ma = [[NSMutableArray alloc] initWithArray:@[@(1),@(3),@(2)]];
//    [ma sortUsingComparator:^NSComparisonResult(NSNumber*  _Nonnull obj1, NSNumber*  _Nonnull obj2) {
//        if (obj1.integerValue > obj2.integerValue) {
//            return NSOrderedAscending;
//        }
//        else {
//            return NSOrderedDescending;
//        }
//    }];
    NSInteger abc = 3;
    NSString* a = [NSString stringWithFormat:@"kkk%@",abc];
    
    UIViewController * test = [[UIViewController alloc]init];
    [test setNavigationTitle:@"你好啊"];
    [self.navigationController pushViewController:test animated:YES];
    
}


- (IBAction)touchUpInsideGcdButton:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"start operation");
        CGFloat k = 9.2324234f;
        CGFloat sum = k;
        for (NSInteger i = 0; i < 0x99FFFFF; i++) {
            if (i%2) {
                sum -= (sum*0.49988);
            }
            else {
                sum += (sum*1.947349);
            }
        }
        NSLog(@"finish operation");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"sum:%@", @(sum));
        });
        

    });
}

@end
