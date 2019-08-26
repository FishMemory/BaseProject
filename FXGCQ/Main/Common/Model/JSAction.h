//
//  JSAction.h
//   
//
//  Created by Michael on 16/7/28.
//  Copyright © 2016年  . All rights reserved.
//

#ifndef JSAction_h
#define JSAction_h

#import <JavaScriptCore/JavaScriptCore.h>


/**
 允许在JS代码里调用OC的代码，并进行App内页面的跳转
 -------------------- JS调用OC示例代码 start ----------------------
 <script type="text/javascript" charset="utf-8">
    function callNativeFunction(cmd, args){
        try {
            return window.NativeObject.execute(cmd, args);
        }catch(err){
            return "";
        }
    }
    function callNativeGetSystem(){
        try {
            return window.NativeObject.getSystem();
        }catch(err){
            return "other";
        }
    }
 </script>
 -------------------- JS调用OC示例代码 end ----------------------
 window.NativeObject.execute(cmd, args);
 参数：cmd，是一个字符串，表示不同的操作。
 参数：args，cmd的参数，根据cmd不同，参数格式不同
 目前支持的cmd：
 1. action：表示一个跳转行为，如app://service?id=1， http://www.126.com
 2. share：表示是一个分享操作，args可为空，为空分享当前页，不为空，分享内容链接
 3. app_auth：表示获得app的授权并返回 json格式用户token和channel_code
 如：{"token":"AABBCC", "channel_code":"xiaomi"}
 
 示例：
 callNativeFunction("action", "app://service?id=1");
 表示是一个跳转，跳转到APP内部页
 
 callNativeFunction("share", ""); 表示分享当前页面
 
 callNativeFunction("app_auth", "");
 如果在App内，并且用户登录，返回：{"token":"AABBCC", "channel_code":"xiaomi"}，否则返回""
 
 window.NativeObject.getSystem()
 获得当前网页是否运行在App内，返回值为Apple表示运行在iOS App内，返回Android表示运行在Android App内。
 
 */
@protocol JSActionProtocol <JSExport>

-(NSString *)execute:(NSString*)cmd :(NSString*)args;

-(NSString*)getSystem;

@end

@interface JSAction : NSObject<JSActionProtocol>

@end

#endif /* JSAction_h */
