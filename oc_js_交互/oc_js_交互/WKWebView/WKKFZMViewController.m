//
//  WKKFZMViewController.m
//  oc_js_交互
//
//  Created by kfz on 16/6/3.
//  Copyright © 2016年 kongfz. All rights reserved.
//  加载孔网M站

#import "WKKFZMViewController.h"
#import <WebKit/WebKit.h>
#import "CookieTool.h"

@interface WKKFZMViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler, WKScriptMessageHandler>
@property (weak, nonatomic) WKWebView *webView;
@end

@implementation WKKFZMViewController

- (WKWebView *)webView {
    if (!_webView ) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.preferences = [[WKPreferences alloc] init];
        configuration.preferences.minimumFontSize = 10.;
        configuration.preferences.javaScriptEnabled = YES;
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        configuration.userContentController = [[WKUserContentController alloc] init];
        
        NSString *source = @"";
        WKUserScript *script = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
        [configuration.userContentController addUserScript:script];
        
        // 添加一个名称，就可以在JS通过这个名称发送消息：
        [configuration.userContentController addScriptMessageHandler:self name:@"TT"];
        
        CGRect rect = [[UIScreen mainScreen] bounds];
        WKWebView *webView = [[WKWebView alloc] initWithFrame:rect configuration:configuration];
        [self.view addSubview:webView];
        _webView = webView;
        // 配置归档
//        [CookieTool arichveConfiguration:configuration];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
    
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    CGSize size = self.view.frame.size;
    NSLog(@"%@",NSStringFromCGSize(size));
    
    self.webView.frame = (CGRect){{0, 0}, {size.width, size.height - 60}};
    [self.view addSubview:self.toolBar];
    self.toolBar.frame = (CGRect){{0, size.height - 60}, {size.width, 60}};
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSURL *url = [NSURL URLWithString:@"http://m.kongfz.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.allowsBackForwardNavigationGestures = YES;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [CookieTool setAllCookie];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)backClicked:(UIButton *)sender {
    [self.webView goBack];
}
- (IBAction)forwardClicked:(UIButton *)sender {
    [self.webView goForward];
}

- (IBAction)refreshClicked:(UIButton *)sender {
    [self.webView reload];
}




- (void)alertMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息提醒" message:message delegate:nil cancelButtonTitle:@"od" otherButtonTitles: nil];
    [alert show];
}


#pragma -mark WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self alertMessage:@"WKScriptMessageHandler"];
}


#pragma -mark WKUIDelegate
/**
 * If you do not implement this method, the web view will cancel the navigation.
 */
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
    NSString *str = @"var footer = document.getElementsByClassName('footer')[0];"
                     "footer.remove();";
    [webView evaluateJavaScript:str completionHandler:nil];
    
    NSArray <NSHTTPCookie *>*cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    if (cookies.count) {
        [self alertMessage:@"发现cookie"];
    }
    
    // dataStore (9.0)
}


@end


















