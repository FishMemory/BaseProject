//
//  UrlParser.m
//   
//
//  Created by Michael on 16/5/12.
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UriParser.h"

@implementation UriParser


/** 单例模式 */
+ (instancetype)actionParser{
    static UriParser* instance = nil;
    
    if (instance == nil) {
        
        static dispatch_once_t token;
        
        dispatch_once(&token, ^{
            instance = [[UriParser alloc]init];
        });
    }
    return instance;
}


/**
 每个app跳转的controller都应该添加到这个actionDict中，否则无法完成自动跳转
 */
- (id)init {
    self = [super init];
    if (self) {
        if(_actionDict == nil){
            _actionDict = [[NSMutableDictionary alloc] init];
//            [_actionDict setObject: NSStringFromClass([SchoolDetailViewController class]) forKey:@"school_page"];
//            [_actionDict setObject: NSStringFromClass([AlumniHomePageViewController class]) forKey:@"alumni_page"];
//            [_actionDict setObject:NSStringFromClass([OrderDTailViewController class]) forKey:@"user_order"];
//            [_actionDict setObject:NSStringFromClass([SchoolRankingController class]) forKey:@"school_rank"];
//            [_actionDict setObject:NSStringFromClass([SchoolListViewController class]) forKey:@"school_list"];
//            [_actionDict setObject:NSStringFromClass([SchoolListViewController class]) forKey:@"high_school_list"];
        }
    }
    return self;
}


/**
 解析action，将协议头，模式对象，和参数列表分别保存到UriBody中
 */
-(NSDictionary *)parseAction:(NSString*)action{
    if(action == nil || action.length == 0)
        return nil;
    NSMutableDictionary * urlBodyDic = [[NSMutableDictionary alloc]  init];
    [urlBodyDic setObject:action forKey:KEY_ACTION];
    
    NSString * lowerAction = [action lowercaseString];
    // 处理头
    NSString* header;
    if([lowerAction hasPrefix:HEADER_HTTP]){
        header = HEADER_HTTP;
    }else if([lowerAction hasPrefix:HEADER_APP]){
        header = HEADER_APP;
    }
    [urlBodyDic setObject:header forKey:KEY_HEADER];
    
    NSRange range = [lowerAction rangeOfString:@"?"];
    NSString* schema;
    // 没有参数列表，直接返回
    if(range.location == NSNotFound){
        schema = [lowerAction substringFromIndex:[header length]];
        [urlBodyDic setObject:schema forKey:KEY_SCHEMA];
//        NSLog(@"withoutHeader = %@", schema);
        return urlBodyDic;
    }
    // 带参数处理
    NSString * args = [lowerAction substringFromIndex:range.location+1];
    NSInteger len = range.location - [header length];
    range.location = [header length];
    range.length = len;
    // 取出目标模式
    schema = [lowerAction substringWithRange:range];
    [urlBodyDic setObject:schema forKey:KEY_SCHEMA];
//    NSLog(@"withoutHeader = %@", schema);
    NSArray * arr = [args componentsSeparatedByString:@"&"];
    if(arr != nil){
        NSMutableDictionary* argDic = [[NSMutableDictionary alloc] init];
        for(int i = 0; i < [arr count]; i++){
            NSString* str = [arr objectAtIndex:i];
            NSArray* arr2 = [str componentsSeparatedByString:@"="];
            if(arr2 == nil || [arr2 count] != 2){
                continue;
            }
            NSString * key = [arr2 objectAtIndex:0];
            NSString * value = [arr2 objectAtIndex:1];
//            NSLog(@"key = %@, value = %@", key, value);
            [argDic setValue:value forKey:key];
        }
        
        [urlBodyDic setObject:argDic forKey:KEY_ARGS];
    }
    return urlBodyDic;
}

-(BOOL)parseActionAndPushViewController:(NSString*)action viewController:(UIViewController*) whichVC
{
    UIViewController* vc = [self getViewControllerFromAction:action];
    if(vc == nil){
        return NO;
    }
    vc.tabBarController.hidesBottomBarWhenPushed = YES;
    [whichVC.navigationController pushViewController:vc animated:YES];
    vc.tabBarController.hidesBottomBarWhenPushed = YES;
    return YES;
}

-(BOOL)parseActionAndPresentViewController:(NSString*)action viewController:(UIViewController*) whichVC
{
    UIViewController* vc = [self getViewControllerFromAction:action];
    if(vc == nil){
        return NO;
    }
    vc.tabBarController.hidesBottomBarWhenPushed = YES;
    [whichVC.navigationController presentViewController:vc animated:YES completion:nil];
    vc.tabBarController.hidesBottomBarWhenPushed = YES;
    return YES;
}

-(UIViewController*)getViewControllerFromAction:(NSString*)action
{
    NSDictionary * urlBody = [self parseAction: action];
    if(urlBody == nil)
        return nil;
    
    UIViewController * viewController = nil;
    if([[urlBody objectForKey:KEY_HEADER] isEqualToString:HEADER_HTTP]){
      
    }else if([[urlBody objectForKey:KEY_HEADER]  isEqualToString:HEADER_APP]){
        NSString * schema = [urlBody objectForKey:KEY_SCHEMA];
        NSString * className = [[[UriParser actionParser] actionDict] objectForKey:schema];
        if(className == nil){
            return nil;
        }else{
            Class clazz = NSClassFromString(className);
            if(clazz == nil){
                return nil;
            }
            viewController = [[clazz alloc]init];
            // 如果是BaseController的子类，将解析出来的Action数据保存在BaseController的userInfo变量里，方便使用
            if([viewController isKindOfClass:[BaseController class]]){
                BaseController * baseVC = (BaseController *)viewController;
                baseVC.userInfo = urlBody;
            }
        }
    }
    return viewController;
}

@end
