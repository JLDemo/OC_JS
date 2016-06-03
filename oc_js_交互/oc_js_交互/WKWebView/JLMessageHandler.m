//
//  JLMessageHandler.m
//  oc_js_交互
//
//  Created by kfz on 16/6/3.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "JLMessageHandler.h"


@implementation JLMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSString *msg = nil;
    if ( [message.body isKindOfClass:[NSString class]] ) {
        msg = message.body;
    }
    [self alertMessage:msg?msg:@"JS调用OC" title:message.name];
}

- (void)alertMessage:(NSString *)message title:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"od" otherButtonTitles: nil];
    [alert show];
}

@end
