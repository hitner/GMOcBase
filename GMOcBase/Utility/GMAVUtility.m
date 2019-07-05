//
//  GMAVUtility.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/11/14.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "GMAVUtility.h"
@import AVFoundation;

@implementation GMAVUtility
+ (void)requestVideoAuthorization:(NSString*)failedTip completionHandler:(void (^)())handler{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusAuthorized:
        {
            if (handler) {
                handler();
            }
        }
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if(granted && handler) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        handler();
                    });
                    
                }
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:
            break;
        case AVAuthorizationStatusDenied:
            break;
        default:
            break;
    }
}


+ (void)requestMicroAuthorization:(NSString*)failedTip completionHandler:(void (^)())handler{
    
}


@end
