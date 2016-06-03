//
//  CookieTool.h
//  app_web
//
//  Created by kfz on 16/5/30.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface CookieTool : NSObject



+ (void)setAllCookie ;
+ (void)updateAllCookie ;
+ (void)logOut ;

+ (void)arichveConfiguration:(WKWebViewConfiguration *)configuration ;
+ (WKWebViewConfiguration *)unArichveConfiguration ;

//+ (void)getCookie ;
//+ (void)saveCookie ;
@end
