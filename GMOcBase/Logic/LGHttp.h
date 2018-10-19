
@interface LGHttp : NSObject
@property(nonatomic, readonly) NSString * host;
@property(nonatomic) NSURLSession * URLSession;

- (instancetype)initWithHost:(NSString*)host;

- (void)getWithPath:(NSString*)path ;




@end
