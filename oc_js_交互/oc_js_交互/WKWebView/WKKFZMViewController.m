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
#import "WKWebView+extension.h"

#define TEST

#ifdef TEST
    #define URLSTRING @"http://m.kongfz.com"
    #define FOOTER @"footer"
#else
    #define URLSTRING @"http://neibumwww.kongfz.com"
    #define FOOTER @"kfz-footer"
#endif

#define TITLE_CLASS @"shop-nav-name"
#define TITLE @"商品详情"



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
        
        NSString *source = @"function getTitle(){"
                            "   var title = document.getElementsByClassName('shop-nav-name')[0]; "
                            "   return title.innerHTML; "
                            "};";
        
        
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
    
    
    NSURL *url = [NSURL URLWithString:URLSTRING];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.allowsBackForwardNavigationGestures = YES;
    // 取出cookie
//    [CookieTool setAllCookie];
    
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息提醒" message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
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
    NSRange range = [str rangeOfString:@"myweb:imageClick:"];
    if (range.location != NSNotFound) {
        [self alertMessage:str];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"%s",__func__);
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    // 移除 footer
    NSString *rmFooter = [NSString stringWithFormat:@"var footer = document.getElementsByClassName('%@')[0];"
                     "footer.remove();",FOOTER];
    [webView evaluateJavaScript:rmFooter completionHandler:nil];
    
    
    NSString *getTitle = @"getTitle();";
    [webView evaluateJavaScript:getTitle completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSString *title = (NSString *)data;
        if ([title isEqualToString:@"商品详情"]) {
            [self alertMessage:@"您已到达“商品详情”页面"];
        }
        
    }];
    
    
}

/*
 *通过js获取htlm中图片url
 */
-(NSArray *)getImageUrlByJS:(WKWebView *)wkWebView
{
    
    //查看大图代码
    //js方法遍历图片添加点击事件返回图片个数
    /*
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByClassName(\"shop-nav-name\");\
    var imgUrlStr='';\
    for(var i=0;i<objs.length;i++){\
    if(i==0){\
    if(objs[i].alt==''){\
    imgUrlStr=objs[i].src;\
    }\
    }else{\
    if(objs[i].alt==''){\
    imgUrlStr+='#'+objs[i].src;\
    }\
    }\
    objs[i].onclick=function(){\
    if(this.alt==''){\
    document.location=\"myweb:imageClick:\"+this.src;\
    }\
    };\
    };\
    return imgUrlStr;\
    };";
    */
    
    NSString *getTitle = @"function getTitle(){"
                          "   var title = document.title;"
                          "   return title; "
                          "}";
    
    //用js获取全部图片
    [wkWebView evaluateJavaScript:getTitle completionHandler:^(id Result, NSError * error) {
        NSLog(@"js___Result==%@",Result);
        NSLog(@"js___Error -> %@", error);
    }];
    
    
    NSString *js2=@"getTitle()";
    
    __block NSArray *array=[NSArray array];
    [wkWebView evaluateJavaScript:js2 completionHandler:^(id Result, NSError * error) {
        NSLog(@"js2__Result==%@",Result);
        NSLog(@"js2__Error -> %@", error);
        
        NSString *resurlt=[NSString stringWithFormat:@"%@",Result];
        
        if([resurlt hasPrefix:@"#"])
        {
            resurlt=[resurlt substringFromIndex:1];
        }
        NSLog(@"result===%@",resurlt);
        array=[resurlt componentsSeparatedByString:@"#"];
        NSLog(@"array====%@",array);
        [wkWebView setMethod:array];
    }];
    
    return array;
}

@end


















