//
//  GMTestViewController.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/10/18.
//  Copyright © 2018年 hitner. All rights reserved.
//

#import "GMTestViewController.h"

#import "GMCore.h"

@interface GMTestViewController ()

@end

@implementation GMTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)touchUpInsideButton:(id)sender {
    [[GMCore singletonCore].concurrentQueue addOperationWithBlock:^{
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
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"sum:%@", @(sum));
        }];
        
    }];
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
