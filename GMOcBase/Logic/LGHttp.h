
@interface LGHttp : NSObject
@property(nonatomic, readonly) NSString * host;

- (instancetype)initWithHost:(NSString*)host;

- (void)getWithPath:(NSString*)path ;




@end
