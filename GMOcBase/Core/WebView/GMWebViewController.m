//
//  GMWebViewController.m
//  GMOcBase
//
//  Created by liu zhuzhai on 2019/12/13.
//

#import "GMWebViewController.h"

@interface GMWebViewController ()
@property (nonatomic) NSURL * willLoadURL;
@end

@implementation GMWebViewController

- (instancetype)init {
    self = [super init];
    
    
    return self;
}

- (instancetype)initWithWebURL:(NSURL*)url {
    self = [self init];
    self.willLoadURL = url;
    return self;
}


- (void)loadView {
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
    //_webView = [[UIWebView alloc] initWithFrame:CGRectZero];// [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
    _webView =  [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
    self.view = _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.willLoadURL) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.willLoadURL]];
    }
    
    _didLoadWebContent = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
