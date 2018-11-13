//
//  JSAction.m
//   
//
//  Created by Michael on 16/7/28.
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSAction.h"
#import "UriParser.h"
#import "AppHelper.h"

@implementation JSAction

-(NSString *)execute:(NSString *)cmd :(NSString *)args
{
    if(cmd == nil || cmd.length <=0 ){
        return @"false";
    }
    
    if([cmd isEqualToString:@"action"]){
        NSLog(@"# action = %@, args = %@", cmd, args);
        APP.currentController.hidesBottomBarWhenPushed = YES;
        [[UriParser actionParser] parseActionAndPushViewController:args viewController:APP.currentController];
        APP.currentController.hidesBottomBarWhenPushed = YES;
        return @"true";
    }else if([cmd isEqualToString:@"share"]){

    }else if([cmd isEqualToString:@"app_auth"]){
        if(APP.isLogin){
            return [NSString stringWithFormat:@"{\"token\":\"%@\",\"channel_code\":\"Apple\"}", APP.token];
        }else{
            return [NSString stringWithFormat:@"{\"token\":\"\",\"channel_code\":\"Apple\"}"];
        }
    }else if([cmd isEqualToString:@"close"]){
        [APP.currentController.navigationController popViewControllerAnimated:YES];
    }else if([cmd isEqualToString:@"go_login"]){
        return @"true";
    }
    return @"false";
}

-(NSString*)getSystem
{
    return @"Apple";
}
@end
