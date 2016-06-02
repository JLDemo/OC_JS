//
//  SCXTestViewController.m
//  oc_js_交互
//
//  Created by kfz on 16/6/1.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "SCXTestViewController.h"

@interface SCXTestViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) UIWebView *webView;
@end

@implementation SCXTestViewController

- (UIWebView *)webView {
    if (!_webView ) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

/*
 kongfz://kongfz.app/toast/
 kongfz://kongfz.app/alert/
 kongfz://kongfz.app/error/
 kongfz://kongfz.app/nav/
 kongfz://kongfz.app/loadData/
 史春祥  17:17:03
 kongfz://kongfz.app/toast/{"type":10001,"callback":"parseDataFromApp(%s)","result":""}
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"SCX_.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    NSString *reg = @"kongfz://kongfz.app/login/";
    NSRange range = [urlString rangeOfString:reg];
    if ( range.location != NSNotFound ) {
        NSString *paramStr = [urlString substringFromIndex:range.location + range.length];
        paramStr = [paramStr stringByRemovingPercentEncoding];
        NSMutableDictionary *params = [NSJSONSerialization JSONObjectWithData:[paramStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        params[@"result"] = @"success logi";
        return NO;
    }
    
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    
}

@end




























