#import "LGHttp.h"
@interface LGHttp()<NSURLSessionDelegate,
NSURLSessionDataDelegate,
NSURLSessionTaskDelegate,
NSURLSessionDownloadDelegate>

@end


@implementation LGHttp
-(instancetype)initWithHost:(NSString *)host {
    self = [[LGHttp alloc] init];
    if (self) {
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSOperationQueue * operationQueue = [[NSOperationQueue alloc] init];
        operationQueue.name = @"com.common.lghttp";
        self.URLSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:operationQueue];
    }
    return self;
}

- (void)getWithPath:(NSString*)path {
}

@end
