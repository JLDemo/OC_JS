//
//  WKWebViwTestVC.m
//  oc_js_交互
//
//  Created by kfz on 16/6/12.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "WKWebViwTestVC.h"
#import <WebKit/WebKit.h>

@interface WKWebViwTestVC ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (weak, nonatomic) WKWebView *webView;

@end

@implementation WKWebViwTestVC
- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKPreferences *preferences = [[WKPreferences alloc] init];
        preferences.minimumFontSize = 10.;
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;
        
        WKUserContentController *contentController = [[WKUserContentController alloc] init];
        NSString *source = @"var t = document.getElementById('test');"
                            "t.innerHTML = 'oc改写了html';";
        WKUserScript *script = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
        [contentController addUserScript:script];
        
        [contentController addScriptMessageHandler:self name:@"TT"];
        
        configuration.userContentController = contentController;
        
        
        CGSize scSize = [UIScreen mainScreen].bounds.size;
        CGRect rect = CGRectMake(0, 0, scSize.width, scSize.height - 60);
        WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        [self.view addSubview:webView];
        _webView = webView;
        
        
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"WKWebView_Test.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma -mark WKWebViewNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSString *str = @"returnTitle();";
    [webView evaluateJavaScript:str completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        ;
    }];
}


#pragma -mark WKUIDelegate
- (void)webViewDidClose:(WKWebView *)webView  {
    NSLog(@"%s",__func__);
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    [self alertMessage:message];
    completionHandler();
}

- (void)alertMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"message" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}


#pragma -mark WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self alertMessage:message.body];
}


@end


















