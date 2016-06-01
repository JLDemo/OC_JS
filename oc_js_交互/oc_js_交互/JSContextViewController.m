//
//  JSContextViewController.m
//  oc_js_交互
//
//  Created by kfz on 16/6/1.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "JSContextViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface JSContextViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) UIWebView *webView;

@end

@implementation JSContextViewController

- (UIWebView *)webView {
    if (!_webView) {
        CGSize scSize = self.view.frame.size;
        UIWebView *webView = [[UIWebView alloc] initWithFrame:(CGRect){{0, 0}, {scSize.width, 220}}];
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /*  oc调用js
     NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
     [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
     self.webView.delegate = self;
     
     */
    
    //    js调用oc
    self.webView.delegate = self;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"JSContext" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    /*
     JSContext作用
     1、为JS添加方法
     2、为JS方法绑定回调block
     */
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"log"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        //        NSLog(@"------:%@",string);
        NSArray *args = [JSContext currentArguments];
        
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
        
        JSValue *this = [JSContext currentThis];
        NSLog(@"this: %@",this);
        NSLog(@"-------End Log-------");
        
    };
    context[@"addButton"] = ^(CGFloat x, CGFloat y){
        UIButton *btn = [[UIButton alloc] initWithFrame:(CGRect){{x, y}, {100, 40}}];
        btn.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:btn];
        [self.view bringSubviewToFront:btn];
    };
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    NSLog(@"%@",urlString);
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    /* oc调用js
     //网页加载完成调用此方法 1
     //    [webView stringByEvaluatingJavaScriptFromString:@"alert('test js OC')"];
     // 2
     //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
     JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
     NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码
     [context evaluateScript:alertJS];//通过oc方法调用js的alert
     */
    //    [webView stringByEvaluatingJavaScriptFromString:@"log('hello world', 'aaa', 1234);"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"addButton(100, 100);"];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    
}



@end












