//
//  WKTestViewController.m
//  oc_js_交互
//
//  Created by kfz on 16/6/2.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "WKTestViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface WKTestViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>
@property (weak, nonatomic) WKWebView *webView;
@end

@implementation WKTestViewController

- (WKWebView *)webView {
    if (!_webView ) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.preferences = [[WKPreferences alloc] init];
        configuration.preferences.minimumFontSize = 10.;
        configuration.preferences.javaScriptEnabled = YES;
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        configuration.userContentController = [[WKUserContentController alloc] init];
        
//        NSString *source = @"var t = document.getElementById('test');"
//                            "t.innerHTML='修改了页面内容';";
//        /* 修改界面的JS，应加在 DocumentEnd */
//        WKUserScript *script = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//        [configuration.userContentController addUserScript:script];
        
        // 添加一个名称，就可以在JS通过这个名称发送消息：
        [configuration.userContentController addScriptMessageHandler:self name:@"TT"];
        
        WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    
////    NSURL *url = [NSURL URLWithString:@"http://www.xianhua.cn/m/?u=318719"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"WKWebView_Test.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
}

- (void)alertMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息提醒" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
- (void)alertMessage:(NSString *)message title:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


#pragma -mark WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSString *msg = nil;
    if ( [message.body isKindOfClass:[NSString class]] ) {
        msg = message.body;
    }
    [self alertMessage:msg?msg:@"JS调用OC" title:message.name];

}


#pragma -mark WKUIDelegate

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    return webView;
}
- (void)webViewDidClose:(WKWebView *)webView {
    [self alertMessage:@"webViewDidClose"];
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    [self alertMessage:message];
    completionHandler();
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
}


#pragma -mark WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *str = webView.URL.absoluteString;
    NSLog(@"%@",str);
    
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"%s",__func__);
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"%s",__func__);
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
//    [webView evaluateJavaScript:str completionHandler:nil];
    
    [webView evaluateJavaScript:@"alertTitle()" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSString *title = (NSString *)data;
        title = [NSString stringWithFormat:@"页面标题：%@",title];
        [self alertMessage:title];
    }];
    
}


@end



















