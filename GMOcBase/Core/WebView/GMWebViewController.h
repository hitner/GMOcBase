//
//  GMWebViewController.h
//  GMOcBase
//
//  Created by liu zhuzhai on 2019/12/13.
//

#import <UIKit/UIKit.h>
@import WebKit;

NS_ASSUME_NONNULL_BEGIN

@interface GMWebViewController : UIViewController

/// 仅在loadView的时候才会创建
@property (nonatomic,readonly) WKWebView * webView;

/// 仅在viewDidLoad中才会加载URL
@property (nonatomic, assign, readonly) BOOL didLoadWebContent;

- (instancetype)initWithWebURL:(NSURL*)url;

- (instancetype)initWithDidLoadCompelete:(GMBlockVoid) compelte;

@end

NS_ASSUME_NONNULL_END
