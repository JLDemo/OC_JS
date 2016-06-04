//
//  WKWebView+extension.m
//  oc_js_交互
//
//  Created by kfz on 16/6/3.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "WKWebView+extension.h"
#import <objc/runtime.h>

@implementation WKWebView (extension)

static char imgUrlArrayKey;
- (void)setMethod:(NSArray *)imgUrlArray
{
    objc_setAssociatedObject(self, &imgUrlArrayKey, imgUrlArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)getImgUrlArray
{
    return objc_getAssociatedObject(self, &imgUrlArrayKey);
}

@end
