//
//  KFZMainViewController.m
//  oc_js_交互
//
//  Created by kfz on 16/6/7.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "KFZMainViewController.h"

@interface KFZMainViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation KFZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
}

- (IBAction)login:(UIButton *)sender {
    NSDictionary *params = @{
                             @"loginName" : @"szws01",
                             @"loginPass" : @"123456",
                             @"appName"   : APPNAME,
                             @"appVersion": VERSION
                             };
    [NetTool loginParams:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self alertMessage:@"登录成功"];
        NSLog(@"%@",responseObject);
        // save token
        NSDictionary *result = responseObject[@"result"];
        NSDefaultSave(result[ACCESS_TOKEN], ACCESS_TOKEN);
        NSDefaultSave(result[REFRESH_TOKEN], REFRESH_TOKEN);
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        // webVeiw
        NSString *str = @"https://neibulogin.kongfz.com/Interface/Sign/dispatch?url=http://neibumwww.kongfz.com&accessToken=38255999490aa825e2acc8a8e74172b2&appName=ANDROID_KFZ_COM&appVersion=1.4.9";
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
        [self.webView loadRequest:request];
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self alertMessage:@"登录失败"];
        NSLog(@"%@",error);
    }];
}


/**
 * accessToken失效后，重新获取
 */
- (IBAction)refreshToken:(id)sender {
    NSLog(@"%@",NSDefault(ACCESS_TOKEN));
    [NetTool refreshTokenSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self alertMessage:@"accessToken refresh 成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self alertMessage:@"accessToken refresh 失败"];
    }];
    /*
     
     /Interface/Sign/refreshToken
     接口参数
     
     名称	参数	描述
     refresh_token	授权token	通过登录接口获得
     appName	应用名称	参见应用名称副本
     appVersion	应用版本	应用版本用于特殊情况服务端可以对特定版本的APP做接口兼容、降级、屏蔽
     */
}

/**
 * 退出登录
 */
- (IBAction)logout:(id)sender {
    [NetTool logout:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self alertMessage:@"退出登录"];
        // delete token
        NSDefaultRemove(ACCESS_TOKEN);
        NSDefaultRemove(REFRESH_TOKEN);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self alertMessage:@"退出失败"];
    }];
}



/**
 * webView调度
 */
- (IBAction)webViewForward:(id)sender { // AFURLResponseSerialization.m
    [NetTool webViewForward:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
}






- (void)alertMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息提醒" message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alert show];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma -mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    
}

@end
























