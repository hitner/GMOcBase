//
//  GMLogEngine.m
//  GMOcBase
//
//  Created by liu zhuzhai on 2020/3/31.
//

#import "GMLogEngine.h"

@interface GMLogEngine()
@property(atomic) NSOperationQueue * logQueue;

@property(nonatomic) NSFileHandle * fileHandle;

@end

@implementation GMLogEngine
IMPLEMENT_SIGNALTON()

- (instancetype)init {
    self = [super init];
    NSOperationQueue *logQueue = [[NSOperationQueue alloc] init];
    logQueue.maxConcurrentOperationCount = 1;
    logQueue.name = @"Logger";
    self.logQueue = logQueue;
    
    
    return self;
}


- (void)logWithLevel:(GMLogLevel)level
                tags:(NSArray *)tags
              format:(NSString*)format, ... {
    
    va_list args;
    
    if (format) {
        va_start(args, format);
        
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        
        va_end(args);
        
        [_logQueue addOperationWithBlock:^{
            [self addLogWithLevel:level message:message];
        }];
    }
}

- (void)addLogWithLevel:(GMLogLevel)level
                message:(NSString*)message {
    NSData * data = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    
    if (@available(iOS 13.0, *)) {
        NSError * error;
        [self.fileHandle writeData:data error:&error];
    } else {
        // Fallback on earlier versions
        [self.fileHandle writeData:data];
    }
    
    if (self.logQueue.operationCount <= 1) {
        //同步file
        [self.fileHandle synchronizeFile];
    }
}
@end
