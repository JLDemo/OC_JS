//
//  NetTool.h
//  oc_js_交互
//
//  Created by kfz on 16/6/7.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^Success)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void(^Failure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);


@interface NetTool : NSObject


/**
 * 用户登录
 */
+ (void)loginParams:(NSDictionary * _Nonnull)params success:(Success  _Nonnull)success failure:(Failure  _Nonnull)failure ;

+ (void)postUrl:(NSString * _Nonnull)urlString params:(NSDictionary * _Nonnull)params success:(Success  _Nonnull)success failure:(Failure  _Nonnull)failure ;

+ (void)getUrl:(NSString * _Nonnull)urlString params:(NSDictionary * _Nonnull)params success:(Success  _Nonnull)success failure:(Failure  _Nonnull)failure ;

@end
