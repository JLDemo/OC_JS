//
//  ViewController.m
//  oc_js_交互
//
//  Created by kfz on 16/5/28.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
//    NSString *str = @"12kkk2k3ookdj"
//            "-------"
//            "+++++++";
//    NSLog(@"%@",str);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 删除
    NSString *str1 = @"var word = document.getElementById('word');";
    NSString *str2 = @"word.remove();";
    [webView stringByEvaluatingJavaScriptFromString:str1];
    [webView stringByEvaluatingJavaScriptFromString:str2];
    // 更改
    NSString *str3 = @"var change = document.getElementsByClassName('change')[0];"
                    "change.innerHTML='thankde';";
    [webView stringByEvaluatingJavaScriptFromString:str3];
    
    // insert picture
    NSString *str4 = @"var img = document.createElement('img');"
                    "img.src = 'test.png';"
                    "img.width = '120';"
                    "img.height = '120';"
                    "document.body.appendChild(img);";
    [webView stringByEvaluatingJavaScriptFromString:str4];
}

@end

















