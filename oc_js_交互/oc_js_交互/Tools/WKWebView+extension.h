//
//  WKWebView+extension.h
//  oc_js_交互
//
//  Created by kfz on 16/6/3.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (extension)

- (void)setMethod:(NSArray *)imgUrlArray ;

- (NSArray *)getImgUrlArray ;

@end
