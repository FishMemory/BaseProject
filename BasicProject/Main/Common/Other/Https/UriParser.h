
//
//  UrlParser.h
//   
//
//  Created by Michael on 16/5/12.
//  Copyright © 2016年  . All rights reserved.
//

#ifndef UrlParser_h
#define UrlParser_h

#define HEADER_HTTP @"http"
#define HEADER_APP @"app://"

@interface UriParser : NSObject

/** 
 action与对应constroller的字典关系
 当给定一个action时对应一个处理的constroller Class类
 */
@property (nonatomic, strong) NSMutableDictionary * actionDict;

- (id)init;


+(instancetype)actionParser;

/**
 解析Action数据，并执行相关的动作
 action的值可以是：
 http://abc.com?id=123&name=bbb
 也可以是
 app://school_page?id=123&name=bbb
 当action以http开头时，自动跳转到自己的WebView里去显示
 当action以app开头时，自动跳转到自己的Controller里
 */
//-(BOOL)parseActionAndPushViewController:(NSString *)action controller:(UIViewController*)controller animated:(BOOL)isAnimate;
//
//-(BOOL)parseActionAndPresentViewController:(NSString *)action controller:(UIViewController*)controller animated:(BOOL)isAnimate;

-(BOOL)parseActionAndPushViewController:(NSString*)action viewController:(UIViewController*) whichVC;

-(BOOL)parseActionAndPresentViewController:(NSString*)action viewController:(UIViewController*) whichVC;

@end

#endif /* UrlParser_h */
