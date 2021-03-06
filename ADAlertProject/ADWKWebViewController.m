//
//  ADWKWebViewController.m
//  ADAlertProject
//
//  Created by xie on 2017/8/14.
//  Copyright © 2017年 xie. All rights reserved.
//



#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "ADWKWebViewController.h"
#import <WebKit/WebKit.h>

@interface  ADWKWebViewController()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (weak, nonatomic) NSString *baseURLString;
@end

@implementation ADWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.wkWebView];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}

#pragma mark - WKWebView WKNavigationDelegate 相关
/// 是否允许加载网页 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    
    urlString = [urlString stringByRemovingPercentEncoding];
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if ([urlComps count]) {
        //        NSString *protocolHead = [urlComps objectAtIndex:0];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (WKWebView *)wkWebView {
    if (_wkWebView == nil) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        webView.navigationDelegate = self;
        // 允许左右划手势导航，默认允许
        webView.allowsBackForwardNavigationGestures = YES;
        _wkWebView = webView;
    }
    
    return _wkWebView;
}


@end
