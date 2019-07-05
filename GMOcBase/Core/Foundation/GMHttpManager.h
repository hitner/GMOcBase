//
//  GMHttpManager.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/10/17.
//  Copyright © 2018年 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LGHttp;
NS_ASSUME_NONNULL_BEGIN

@interface GMHttpManager : NSObject
DECLARE_SIGNALTON()

@property(nonatomic) LGHttp * mainHost;

/// common data task, use sharedSession for image/
- (NSURLSessionDataTask *)dataGETWithURL:(NSURL*)url
                                  result:(void(^)(NSData* image, NSError* error))callback;

- (void)getWithPath:(NSString*) path
            success:(void(^)(NSDictionary*))success
             failed:(void(^)(NSError*))failed;

- (void)getWithPath:(NSString*) path
            noCache:(BOOL)noCache
         retryCount:(NSInteger)count
            timeout:(CGFloat)timeout
            success:(void(^)(NSDictionary*))success
             failed:(void(^)(NSError*))failed;

- (void)longPollGetWithPath:(NSString*) path
                    success:(void(^)(NSDictionary*))success
                     failed:(void(^)(NSError*))failed;

- (void)getWithPath:(NSString*) path
            options:(NSDictionary*)options
            success:(void(^)(NSDictionary*))success
             failed:(void(^)(NSError*))failed;


- (void)postWithPath:(NSString *) path
      bodyParameters:(NSDictionary *)params
             success:(void(^)(NSDictionary*))success
              failed:(void(^)(NSError*))failed;

- (void)method:(NSString*) method
      withPath:(NSString*) path
       options:(NSDictionary*)options
bodyParameters:(NSDictionary *)params
       success:(void(^)(NSDictionary*))success
        failed:(void(^)(NSError*))failed;
@end

NS_ASSUME_NONNULL_END
