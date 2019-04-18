//
//  GMHttpManger.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/10/17.
//  Copyright © 2018年 hitner. All rights reserved.
//

#import "GMHttpManager.h"
#import "GMURLSessionManager.h"

@implementation GMHttpManager

IMPLEMENT_SIGNALTON(GMHttpManager)

- (void)dataGETWithUrlString:(NSString*)url
                    result:(void(^)(NSData* image, NSError* error))callback {
    NSURLSessionDataTask * dataTask =  [[GMURLSessionManager sharedObject].commonMainQueueSession
                                        dataTaskWithURL:[NSURL URLWithString:url]
        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (data && !error) {
        if (callback) {
            callback(data, nil);
        }
    }
    else {
        if (callback) {
            callback(nil, error);
        }
    }
    }];
    [dataTask resume];
}
@end
