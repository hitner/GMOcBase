//
//  GMWarmUp.m
//  GMOcBase_Example
//
//  Created by liu zhuzhai on 2019/9/30.
//  Copyright © 2019 hitner. All rights reserved.
//

#import "GMWarmUp.h"
#import "NSString+GM.h"
#import <CommonCrypto/CommonDigest.h>

@interface GMWarmUp()
@property(nonatomic) NSTimer * timer;

@end

@implementation GMWarmUp
IMPLEMENT_SIGNALTON()

- (void)warmUp {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [[GMCore sharedObject].concurrentQueue addOperationWithBlock:^{
            [self cpuTask];
        }];
        [[GMCore sharedObject].concurrentQueue addOperationWithBlock:^{
            [self cpuTask];
        }];
        [[GMCore sharedObject].concurrentQueue addOperationWithBlock:^{
            [self cpuTask];
        }];
        [[GMCore sharedObject].concurrentQueue addOperationWithBlock:^{
            [self cpuTask];
        }];
        [[GMCore sharedObject].concurrentQueue addOperationWithBlock:^{
            [self cpuTask];
        }];
        [self oneTask];
        
    }];
}

- (void)stopWarm {
    [self.timer invalidate];
    self.timer = nil;
}



- (void)oneTask {
    for (NSUInteger i = 0; i < 9000000;  i++) {
        NSString * string = [NSString stringWithFormat:@"上看风景开始打卡🉑️d😄%@kkajfkjsdll.c¥%……&**(*^SFKSDfj%ld",@(i*0.8),i];
        CGFloat lenght = [string fitWidthWithFontSize:11.0];
        NSLog(@"random:%@,%@",@(random()),@(lenght));
    }
}

- (void)cpuTask {
    for (NSUInteger i = 0; i < LONG_MAX - 100;  i++) {
        NSString * string = [NSString stringWithFormat:@"aksdjf卡戴假发开始上看风景开始打卡🉑️d😄%@kkajfkjsdll.c¥%……&**(*^SFKSDfj%ld",@(i*0.8),i];
        NSString * kk = [self sha1:string];
    }
}

- (NSString *)sha1:(NSString*)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}
@end
