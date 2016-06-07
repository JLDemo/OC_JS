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
 * 用户登录
 */
+ (void)loginParams:(NSDictionary * _Nonnull)params success:(Success  _Nonnull)success failure:(Failure  _Nonnull)failure {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",SERVER,LOGIN];
    [self postUrl:urlString params:params success:success failure:failure];
}




+ (void)postUrl:(NSString * _Nonnull)urlString params:(NSDictionary * _Nonnull)params success:(Success  _Nonnull)success failure:(Failure  _Nonnull)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:params progress:nil success:success failure:failure];
}

+ (void)getUrl:(NSString * _Nonnull)urlString params:(NSDictionary * _Nonnull)params success:(Success  _Nonnull)success failure:(Failure  _Nonnull)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString parameters:params progress:nil success:success failure:failure];
}

@end
