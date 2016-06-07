//
//  KFZMainViewController.m
//  oc_js_交互
//
//  Created by kfz on 16/6/7.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "KFZMainViewController.h"

@interface KFZMainViewController ()

@end

@implementation KFZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)login:(UIButton *)sender {
    NSDictionary *params = @{
                             @"loginName" : @"吴贞利",
                             @"loginPass" : @"123321",
                             @"appName"   : APPNAME,
                             @"appVersion": @"1.0"
                             };
    [NetTool loginParams:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        [self alertMessage:@"登录成功"];
        
        if (error == nil) {
            [self alertMessage:@"登录成功"];
            NSLog(@"%@",resultDic);
        }else {
            [self alertMessage:@"登录失败"];
            NSLog(@"%@",error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self alertMessage:@"登录失败"];
        NSLog(@"%@",error);
    }];
    
    /*
     接口参数
     
     名称	参数	描述
     loginName	登录名	可以是用户名，昵称，手机，邮箱
     loginPass	密码	登录的密码
     appName	应用名称	参见应用名称副本
     appVersion	应用版本	应用版本用于特殊情况服务端可以对特定版本的APP做接口兼容、降级、屏蔽

     */
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

@end
