//
//  NetTool.m
//  oc_js_交互
//
//  Created by kfz on 16/6/7.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "NetTool.h"

@implementation NetTool

/**
 * webView调度
 */
+ (void)webViewForward:(Success  _Nonnull)success failure:(Failure  _Nonnull)failure {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",SERVER,@"/Interface/Sign/dispatch"];
    
    NSDictionary *params = @{
//                             @"accessToken"  : NSDefault(ACCESS_TOKEN),
                             @"url"           : @"http://www.baidu.com",
                             @"appName"       : APPNAME,
                             @"appVersion"    : VERSION
                             };
    
    [self postUrl:urlString params:params success:success failure:failure];
}


/**
 * 退出登录
 */
+ (void)logout:(Success  _Nonnull)success failure:(Failure  _Nonnull)failure {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",SERVER,LOGOUT];
    
    NSDictionary *params = @{
                             @"accessToken" : NSDefault(ACCESS_TOKEN),
                             @"appName"       : APPNAME,
                             @"appVersion"    : VERSION
                             };
    
    [self postUrl:urlString params:params success:success failure:failure];
    /*
     refresh_token	授权token	通过登录接口获得
     appName	应用名称	参见应用名称副本
     appVersion
     */
}


/**
 * accessToken失效后，重新获取
 */
+ (void)refreshTokenSuccess:(Success  _Nonnull)success failure:(Failure  _Nonnull)failure {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",SERVER,REFRESH];
    
    NSDictionary *params = @{
                             @"refreshToken" : NSDefault(REFRESH_TOKEN),
                             @"appName"       : APPNAME,
                             @"appVersion"    : VERSION
                             };
    
    [self getUrl:urlString params:params success:success failure:failure];
    /*
     refresh_token	授权token	通过登录接口获得
     appName	应用名称	参见应用名称副本
     appVersion
     */
}

/**
 * 用户登录
 */
+ (void)loginParams:(NSDictionary * _Nonnull)params success:(Success  _Nonnull)success failure:(Failure  _Nonnull)failure {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",SERVER,LOGIN];
    [self postUrl:urlString params:params success:success failure:failure];
//    [self getUrl:urlString params:params success:success failure:failure];
}



/**
 * 发送post请求
 */
+ (void)postUrl:(NSString * _Nonnull)urlString params:(NSDictionary * _Nonnull)params success:(Success  _Nonnull)success failure:(Failure  _Nonnull)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:params progress:nil success:success failure:failure];
}

/**
 * 发送get请求
 */
+ (void)getUrl:(NSString * _Nonnull)urlString params:(NSDictionary * _Nonnull)params success:(Success  _Nonnull)success failure:(Failure  _Nonnull)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString parameters:params progress:nil success:success failure:failure];
}

@end





