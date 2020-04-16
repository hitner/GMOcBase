//
//  GMLogEngine.h
//  GMOcBase
//
//  Created by liu zhuzhai on 2020/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GMLogLevel) {
    GMLogLevelDebug,
    GMLogLevelInfo,
    GMLogLevelWarn,
    GMLogLevelError
};

@interface GMLogEngine : NSObject
DECLARE_SIGNALTON()

- (void)logWithLevel:(GMLogLevel)level
                tags:(NSArray * __nullable )tags
              format:(NSString*)format, ... NS_FORMAT_FUNCTION(3,4);

@end

NS_ASSUME_NONNULL_END
