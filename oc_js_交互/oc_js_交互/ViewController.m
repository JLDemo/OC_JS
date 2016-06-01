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

@property (weak, nonatomic) IBOutlet UIStackView *activiteIndicater;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://www.xianhua.cn/m/?u=318719"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [self.webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self modifyWeb:webView];
    /*
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
     */
}

- (void)modifyWeb:(UIWebView *)webView {
    NSString *delFooter = @"var footer = document.getElementById('footer');"
                        "footer.remove();";
    [webView stringByEvaluatingJavaScriptFromString:delFooter];
    //  document.getElementsByTagName(tagname)    blerowObject.innerHTML=HTML
    NSString *modifyH1 = @"var h1 = document.getElementsByTagName('h1')[0];"
                        "h1.innerHTML='+++++++';";
    [webView stringByEvaluatingJavaScriptFromString:modifyH1];
    
    NSString *str4 = @"if( !document.getElementById('newImage') ) {"
    "var image = document.createElement('img');"
    "image.src = 'https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1464762937&di=db309f9e5353173fd657aa1c075515cb&src=http://cdnweb.b5m.com/web/cmsphp/article/201505/0af6a614b197efa883bbfbbe2e2078c8.jpg';"
    "image.width = '120';"
    "image.height = '120';"
    "image.id='newImage';"
    "document.body.appendChild(image);"
    "}";
    [webView stringByEvaluatingJavaScriptFromString:str4];
}

@end

















