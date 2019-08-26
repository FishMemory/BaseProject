//
//  HttpServes.m
//   
//
//  Created by 宋亚清 on 16/3/4.
//  Copyright © 2016年  . All rights reserved.
//

#import "HttpServices.h"

#import "JSONKit.h"

#import "Http.h"

#import "AES128.h"

#import "NetworkUtils.h"

#import "progressHUD.h"

#import "AppHelper.h"

#import "AFHTTPSessionManager.h"

@implementation Pagination
-(NSString*)getPageUrl:(NSInteger)pageNumber
{
    if(_baseUrl == nil || _baseUrl.length <= 0){
        return nil;
    }
    if(pageNumber > _totalPageCount){
        return nil;
    }
    
    NSRange range = [_baseUrl rangeOfString:@"page=" options:NSCaseInsensitiveSearch];
    NSString* formateBaseUrl = _baseUrl;
    if (range.location != NSNotFound){
        formateBaseUrl = [_baseUrl substringToIndex:range.location];
        return  [NSString stringWithFormat:@"%@page=%@", formateBaseUrl, @(pageNumber)];
    }else{
        NSRange rangePage = [_baseUrl rangeOfString:@"?" options:NSCaseInsensitiveSearch];
        if(rangePage.location != NSNotFound){
            return  [NSString stringWithFormat:@"%@&page=%@", formateBaseUrl, @(pageNumber)];
        }else{
            return  [NSString stringWithFormat:@"%@?page=%@", formateBaseUrl, @(pageNumber)];
        }
    }
    return nil;
}
@end

@implementation HttpServices
+ (AFSecurityPolicy *)sharedSecurityPolicy {
    //它还接收一个希望在应用的生命周期内仅被调度一次的代码块，对于本例就用于shared实例的实例化。
    //  dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的，这就意味着你不需要使用诸如
    static dispatch_once_t onceQueue;
    static AFSecurityPolicy *policyInstance;
    dispatch_once(&onceQueue, ^{
        // MichaelTang add 2016.07.07 for https
        NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"api. .com" ofType:@"der"];
        NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
        if (!certData) {
            return ;
        }
        NSSet *certSet = [NSSet setWithObject:certData];
        policyInstance = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey withPinnedCertificates:certSet];
        //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
        //如果是需要验证自建证书，需要设置为YES
        policyInstance.allowInvalidCertificates = YES;
        //validatesDomainName 是否需要验证域名，默认为YES；
        //假如证书的域名与你请求的域名不一致，需把该项设置为NO
        //主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
        policyInstance.validatesDomainName = YES;
        //validatesCertificateChain 是否验证整个证书链，默认为YES
        //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
        //GeoTrust Global CA
        //    Google Internet Authority G2
        //        *.google.com
        //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
        //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证；
        //        securityPolicy.va = NO;
    });
    return policyInstance;
}

-(void)showProgressInMainThread: (dispatch_block_t) block
{
    dispatch_async(dispatch_get_main_queue(), block);
}



/**
 如果两次相同请求间隔不超过3秒，则提示用户
 */
+(BOOL)multiQuickAction:(NSString*)action minDelay:(NSInteger)delay
{
    // 上次请求的URL地址
    static NSString * lastRequestURL = nil;
    // 上次请求的时间
    static NSTimeInterval lastTime = 0;
    
    NSTimeInterval now =[[NSDate date] timeIntervalSince1970];
    
    // 如果两次相同请求间隔不超过3秒，则提示用户
    if(lastRequestURL != nil && [lastRequestURL isEqualToString:action] && now - lastTime < delay){
        return YES;
    }
    
    lastTime = now;
    lastRequestURL = action;
    return NO;
}

/**
 * 基于RESTful的GET请求
 * 用于获取API信息
 * 分页信息保存在
 */
+(void)get:(NSString*)url _id:(NSNumber*)_id  showBackProgressHD:(BOOL)show  token:(NSString*)token  showError:(BOOL)showErrorToast
   success:(Success)success
apiErroBlock:(APIErrorBlock)apiError
networkErroBlock:(ErrorBlock)networkError
{
    if ([NetworkUtils checkNetWork:nil]){
    }else{
        [[ProgressHUD instance] showBackProgressHD:show inView:APP.window info:@""];
        NSLog(@"####>>>> 用户token ：%@",token);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSRange range = [url rangeOfString:@"https"options:NSCaseInsensitiveSearch];
        
        if (range.location != NSNotFound){
            manager.securityPolicy = [HttpServices sharedSecurityPolicy];
            manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        }
        
        // 注意
        // [manager.operationQueue cancelAllOperations];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        // AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        manager.requestSerializer.timeoutInterval = 15.0;
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        NSString* tokenParm = @"";
        if(token != nil || token.length > 0){
            tokenParm = token;
        }
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", tokenParm] forHTTPHeaderField:@"Authorization"];
        
        // 区分测试模式和正式模式
#ifdef DEBUG
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-TEST-MODE"];
#elif defined PROD
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-TEST-MODE"];
#endif
        // 将_id和url拼接
        NSString *urlString = url;
        if(_id != nil && [_id integerValue] > 0){
            urlString= [NSString stringWithFormat:@"%@/%@", url, _id];
        }
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"####>>>> 请求的 urlStr = %@",urlString);
        
        [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 接收数据处理
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSDictionary *allHeaders = response.allHeaderFields;
            
            // v1.41开始不再使用自己的加密，而使用了Https
            // API接口里加密数据有问题，PHP返回的是实体Model的加密，导致数据有问题
            // 检查服务器响应有没有加密
            //            NSString* encode = [allHeaders valueForKey:@"encode"];
            //            NSString* sign = [allHeaders valueForKey:@"sign"];
            //            NSString* timestamp = [allHeaders valueForKey:@"timestamp"];
            
            NSNumber* curPage = [allHeaders objectForKey:@"X-Pagination-Current-Page"];
            NSNumber* pageCount = [allHeaders objectForKey:@"X-Pagination-Page-Count"];
            NSNumber* countPerPage = [allHeaders objectForKey:@"X-Pagination-Per-Page"];
            NSNumber* totalCount = [allHeaders objectForKey:@"X-Pagination-Total-Count"];
            NSLog(@"####>>>> 页数 %@",pageCount);
            
            Pagination* page = nil;
            if(curPage != nil && pageCount != nil && countPerPage != nil && totalCount != nil){
                page = [[Pagination alloc]init];
                page.currentPageNumber = [curPage integerValue];
                page.totalPageCount = [pageCount integerValue];
                page.totalDataCount = [totalCount integerValue];
                page.countPerPage = [countPerPage integerValue];
                page.baseUrl = url;
            }
            
            
            NSDictionary* respObj = responseObject;
            
            //  隐藏进度圈
            [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"正在载入，请稍候..."];
            
            // API接口返回错误
            NSNumber* code = nil;
            NSString *error = nil;
            @try {
                code = [respObj objectForKey:@"code"];
                error = [respObj objectForKey:@"message"];
                error =  error.length > 0 ? error : [responseObject objectForKey:@"msg"];
            } @catch (NSException *exception) {
            }
            // code返回非0,说明接口返回错误
            if (code != nil && ![code isEqualToNumber:@200]) {
                if ([code isEqualToNumber:@5003]){
                    //                [AccountValidate AppLogOut];

                }else{
                    if (error.length > 0 && showErrorToast)
                        SHOW_WARN_INFO(APP.window, 2.5, error);
                
                    NSLog(@"## 接口返回失败");
                    if(apiError != nil){
                        apiError(respObj);
                        return;
                    }
                }
             
            }else{
                // 接口里没有code值，说明API返回正常数据
                //                NSLog(@"接口请求成功%@", [respObj JSONString]);
                success(respObj, page);
                return ;
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            if(response.statusCode == 500){
                NSLog(@"## 内部服务器错误");
                if(showErrorToast)
                    SHOW_WARN_INFO(APP.window, 2.5, @"内部服务器错误，程序猿们在努力修复中");
            }else if(response.statusCode == 503){
                NSLog(@"## 服务器宕机");
                if(showErrorToast)
                    SHOW_WARN_INFO(APP.window, 2.5, @"服务器累了，暂时休息一会");
            }else if (error.code == 5003){
                
                
            }else{
                
                NSLog(@"## 服务器挂了 错误码 %@",@(response.statusCode));
                if(showErrorToast)
                    SHOW_WARN_INFO(APP.window, 2.5, @"网络开小差了");
            }
            if(networkError)
                networkError(task, error);
        }];
    }
}

/**
 * 基于RESTful的post请求
 * 用于向API里添加数据
 */
+(void)post:(NSString*)url _id:(NSNumber*)_id showBackProgressHD:(BOOL)show token:(NSString*)token   showError:(BOOL)showErrorToast dataDic:(NSDictionary*)dataDic
    success:(Success)success
apiErroBlock:(APIErrorBlock)apiError
networkErroBlock:(ErrorBlock)networkError
{
    // 将_id和url拼接
    NSString *urlString = url;
    if(_id != nil && [_id integerValue] > 0){
        urlString= [NSString stringWithFormat:@"%@/%@", url, _id];
    }
    
    if([HttpServices multiQuickAction:[@"post_" stringByAppendingString:urlString] minDelay:1]){
        //        SHOW_WARN_INFO(APP.window, 2, @"重复的提交请求");
        return;
    }
    if ([NetworkUtils checkNetWork:nil]){
    }else{
        
        [[ProgressHUD instance] showBackProgressHD:show inView:APP.window info:@"正在载入，请稍候..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSRange range = [url rangeOfString:@"https"options:NSCaseInsensitiveSearch];
        
        if (range.location != NSNotFound){
            manager.securityPolicy = [HttpServices sharedSecurityPolicy];
            manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        }
        
        // 注意
        // [manager.operationQueue cancelAllOperations];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 15.0;
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"]; 
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", APP.curUserId]  forHTTPHeaderField:@"x-header-uid"];
        // ios-1.0后面的版本号和App内的版本号一致
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString * version = [NSString stringWithFormat:@"ios-%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];

        [manager.requestSerializer setValue:version forHTTPHeaderField:@"x-header-version"];
        NSString * tkn = token;
        if(tkn == nil || tkn.length <= 0){
            tkn = @"";
        }
        [manager.requestSerializer setValue:tkn forHTTPHeaderField:@"x-header-token"];
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"x-header-sign"];
        
        // 区分测试模式和正式模式
#ifdef DEBUG
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-TEST-MODE"];
#elif defined PROD
        [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"X-TEST-MODE"];
#endif
        
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"####>>>>urlStr = %@",urlString);
        NSLog(@"####>>>>上传数据 %@", dataDic);
    
        [manager POST:urlString parameters:dataDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //  隐藏进度圈
            [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
            NSNumber* curPage = [responseObject objectForKeyCheck:@"page"];
            NSNumber* pageCount = [responseObject objectForKeyCheck:@"pages"];
            NSLog(@"####>>>> 页数 %@",pageCount);
            Pagination *page = nil;
            if(curPage != nil && pageCount != nil){
                page = [[Pagination alloc]init];
                page.currentPageNumber = [curPage integerValue];
                page.totalPageCount = [pageCount integerValue];
                page.baseUrl = url;
            }
            
            
            //            NSLog(@"服务器响应数据 %@",responseObject);
            
            
            // API接口返回错误
            NSNumber* code = nil;
            NSString *error = nil;
            @try {
                code = [responseObject objectForKey:@"code"];
                error = [responseObject objectForKey:@"msg"];
//                error =  error.length > 0 ? error : [responseObject objectForKey:@"msg"];
            } @catch (NSException *exception) {
            }
            // code返回非200,说明接口返回错误
            if (code != nil && ![code isEqualToNumber:@200] && ![code isEqualToNumber:@199] && ![code isEqualToNumber:@201]) {
                if ([code isEqualToNumber: @5003]){
//                    [AccountValidate autoLogin:^(NSDictionary *dic) {
//                    } fail:^(NSDictionary *dic) {
//                        
//                    }];
                }else{
                    if (error.length > 0 && showErrorToast)
                    SHOW_WARN_INFO(APP.window, 1.5, error);
                }
                NSLog(@"## 接口返回失败 %@\n%@",url,responseObject);
                if(apiError != nil){
                    apiError(responseObject);
                    return;
                }
            }else{
                // 接口里没有code值，说明API返回正常数据
//                NSLog(@"接口请求成功%@", [responseObject JSONString]);
                if(success){
                    success(responseObject, page);
                }
                return ;
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            if(response.statusCode == 500){
                NSLog(@"## 内部服务器错误");
                if(showErrorToast)
                    SHOW_WARN_INFO(APP.window, 1.5, @"内部服务器错误，程序猿们在努力修复中");
            }else if(response.statusCode == 503){
                NSLog(@"## 服务器宕机");
                if(showErrorToast)
                    SHOW_WARN_INFO(APP.window, 1.5, @"服务器累了，暂时休息一会");
                
            }else if (error.code == 5003){

                
            }else{
                NSLog(@"## 服务器挂了");
                if(showErrorToast)
                    SHOW_WARN_INFO(APP.window, 1.5, @"网络开小差了");
            }
            NSLog(@"网络请求错误信息 %@",error.userInfo);
            if(networkError)
                networkError(task, error);
        }];
    }
}


/**
 * 基于RESTful的put请求
 * 用于更新API数据信息
 */
+(void)put:(NSString*)url _id:(NSNumber*)_id  showBackProgressHD:(BOOL)show  paramete:(NSString *)paramete token:(NSString*)token  showError:(BOOL)showErrorToast dataDic:(NSDictionary*)dataDic
   success:(Success)success
apiErroBlock:(APIErrorBlock)apiError
networkErroBlock:(ErrorBlock)networkError
{
    // 将_id和url拼接
    NSString *urlString = url;
    if(_id != nil && [_id integerValue] > 0){
        paramete = paramete.length > 0 ? [@"/" stringByAppendingString:paramete ]: @"";
        urlString= [NSString stringWithFormat:@"%@/%@%@", url, _id,paramete];
    }
    
    if([HttpServices multiQuickAction:[@"post_" stringByAppendingString:urlString] minDelay:1]){
        SHOW_WARN_INFO(APP.window, 2, @"重复的提交请求");
        return;
    }
    if ([NetworkUtils checkNetWork:nil]){
    }else{
        [[ProgressHUD instance] showBackProgressHD:show inView:APP.window info:@"正在载入，请稍候..."];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSRange range = [url rangeOfString:@"https"options:NSCaseInsensitiveSearch];
        
        if (range.location != NSNotFound){
            manager.securityPolicy = [HttpServices sharedSecurityPolicy];
            manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        }
        
        // 注意
        // [manager.operationQueue cancelAllOperations];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        // AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        manager.requestSerializer.timeoutInterval = 15.0;
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        NSString* tokenParm = @"";
        if(token != nil || token.length > 0){
            tokenParm = token;
        }
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", tokenParm] forHTTPHeaderField:@"Authorization"];

        // 区分测试模式和正式模式
#ifdef DEBUG
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-TEST-MODE"];
#elif defined PROD
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-TEST-MODE"];
#endif
        
        // 将_id和url拼接
        //        NSString *urlString = url;
        //        if(_id != nil && [_id integerValue] > 0){
        //            paramete = paramete.length > 0 ? [@"/" stringByAppendingString:paramete ]: @"";
        //            urlString= [NSString stringWithFormat:@"%@/%@%@", url, _id,paramete];
        //        }
        //        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"####>>>>urlStr = %@",urlString);
        
        NSLog(@"####>>>>上传数据 %@", [dataDic JSONString]);
        
        [manager PUT:urlString parameters:dataDic
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             // 接收数据处理
             //             NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
             //             NSDictionary *allHeaders = response.allHeaderFields;
             
             //             NSLog(@"服务器响应数据 %@",responseObject);
             
             //  隐藏进度圈
             [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
             
             // API接口返回错误
             NSNumber* code = nil;
             NSString *error = nil;
             @try {
                 code = [responseObject objectForKey:@"code"];
                 error = [responseObject objectForKey:@"message"];
                 error =  error.length > 0 ? error : [responseObject objectForKey:@"msg"];
             } @catch (NSException *exception) {
             }
             // code返回非200,说明接口返回错误
             if (code != nil && ![code isEqualToNumber:@200]) {
                 [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
                 
                 if ([code isEqualToNumber: @5003]){

                 }else{
                     if (error.length > 0 && showErrorToast)
                         SHOW_WARN_INFO(APP.window, 1.5, error);
                 }
                 
                 NSLog(@"## 接口返回失败");
                 if(apiError != nil){
                     apiError(responseObject);
                     return;
                 }
             }else{
                 // 接口里没有code值，说明API返回正常数据
                 NSLog(@"接口请求成功%@", [responseObject JSONString]);
                 success(responseObject, nil);
                 return ;
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
             NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
             
             if(response.statusCode == 500){
                 NSLog(@"## 内部服务器错误");
                 if(showErrorToast)
                     SHOW_WARN_INFO(APP.window, 1.5, @"内部服务器错误，程序猿们在努力修复中");
             }else if(response.statusCode == 503){
                 NSLog(@"## 服务器宕机");
                 if(showErrorToast)
                     SHOW_WARN_INFO(APP.window, 1.5, @"服务器累了，暂时休息一会");
             }else if (error.code == 5003){

                 
             }else{
                 NSLog(@"## 服务器挂了");
                 if(showErrorToast)
                     SHOW_WARN_INFO(APP.window, 1.5, @"网络开小差了");
             }
             if(networkError)
                 networkError(task, error);
             
         }];
    }
}


/**
 * 基于RESTful的Delete请求
 * 用于删除API指定的数据
 */
+(void)restDelete:(NSString*)url _id:(NSNumber*)_id  showBackProgressHD:(BOOL)show  token:(NSString*)token showError:(BOOL)showErrorToast
          success:(Success)success
     apiErroBlock:(APIErrorBlock)apiError
 networkErroBlock:(ErrorBlock)networkError
{
    // 将_id和url拼接
    NSString *urlString = url;
    if(_id != nil && [_id integerValue] > 0){
        urlString= [NSString stringWithFormat:@"%@/%@", url, _id];
    }
    
    if([HttpServices multiQuickAction:[@"post_" stringByAppendingString:urlString] minDelay:1]){
        //        SHOW_WARN_INFO(APP.window, 2, @"重复的提交请求");
        return;
    }
    
    if ([NetworkUtils checkNetWork:nil]){
    }else{
        [[ProgressHUD instance] showBackProgressHD:show inView:APP.window info:@"正在载入，请稍候..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSRange range = [url rangeOfString:@"https"options:NSCaseInsensitiveSearch];
        if (range.location != NSNotFound){
            manager.securityPolicy = [HttpServices sharedSecurityPolicy];
            manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        }
        // 注意
        // [manager.operationQueue cancelAllOperations];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        // AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        manager.requestSerializer.timeoutInterval = 15.0;
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        NSString* tokenParm = @"";
        if(token != nil || token.length > 0){
            tokenParm = token;
        }
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", tokenParm] forHTTPHeaderField:@"Authorization"];

        // 区分测试模式和正式模式
#ifdef DEBUG
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-TEST-MODE"];
#elif defined PROD
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-TEST-MODE"];
#endif
        // 将_id和url拼接
        NSString *urlString = url;
        if(_id != nil && [_id integerValue] > 0){
            urlString= [NSString stringWithFormat:@"%@/%@", url, _id];
        }
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"####>>>>urlStr = %@",urlString);
        
        [manager DELETE:urlString parameters:nil
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"服务器响应数据 %@",responseObject);
             
             //  隐藏进度圈
             [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
             
             // API接口返回错误
             NSNumber* code = nil;
             NSString *error = nil;
             @try {
                 code = [responseObject objectForKey:@"code"];
                 error = [responseObject objectForKey:@"message"];
                 error =  error.length > 0 ? error : [responseObject objectForKey:@"msg"];
             } @catch (NSException *exception) {
             }
             // code返回非0,说明接口返回错误
             if (code != nil && ![code isEqualToNumber:@200]) {
                 if ([code isEqualToNumber: @5003]){

                 }else{
                     if (error.length > 0 && showErrorToast)
                         SHOW_WARN_INFO(APP.window, 1.5, error);
                 }
                 
                 NSLog(@"## 接口返回失败");
                 if(apiError != nil){
                     apiError(responseObject);
                     return;
                 }
             }else{
                 // 接口里没有code值，说明API返回正常数据
                 NSLog(@"接口请求成功%@", [responseObject JSONString]);
                 success(responseObject, nil);
                 return ;
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
             NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
             if(response.statusCode == 500){
                 NSLog(@"## 内部服务器错误");
                 if(showErrorToast)
                     SHOW_WARN_INFO(APP.window, 1.5, @"内部服务器错误，程序猿们在努力修复中");
             }else if(response.statusCode == 503){
                 NSLog(@"## 服务器宕机");
                 if(showErrorToast)
                     SHOW_WARN_INFO(APP.window, 1.5, @"服务器累了，暂时休息一会");
             }else if (error.code == 5003){

                 
             }else{
                 NSLog(@"## 服务器挂了");
                 if(showErrorToast)
                     SHOW_WARN_INFO(APP.window, 1.5, @"网络开小差了");
             }
             if(networkError)
                 networkError(task, error);
             
         }];
    }
}

+(void)uploadFile:(NSData*)data upLoadUrl:(NSString*)upLoadUrl success:(SuccessBlock)sucess failed:(APIErrorBlock)failed
{
    [[ProgressHUD instance] showBackProgressHD:YES inView:APP.window info:@"正在上传"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    [manager POST:upLoadUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%f.png", [[NSDate date] timeIntervalSince1970]] mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"正在上传"];
        SHOW_WARN_INFO(APP.window, 1.5, @"上传成功");
        if(sucess){
            sucess(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"正在上传"];
        
        SHOW_WARN_INFO(APP.window, 1.5, @"上传失败");
        if(failed){
            failed(nil);
        }
    }];
}

#define UPLOAD_FILE @"上传地址"

+(void)uploadFileWithFormat:(NSData*)data format:(NSString *)suffix success:(SuccessBlock)sucess failed:(APIErrorBlock)failed
{
    if(suffix == nil){
        SHOW_WARN_INFO(APP.window, 1.5, @"指定上传格式format");
        if(failed){
            failed(nil);
        }
        return;
    }
    [[ProgressHUD instance] showBackProgressHD:YES inView:APP.window info:@"正在上传"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager POST:UPLOAD_FILE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if([suffix isEqualToString:@"jpg"]){
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%ld.jpg", (long)[[NSDate date] timeIntervalSince1970]] mimeType:@"image/jpeg"];
        }else if([suffix isEqualToString:@"png"]){
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%ld.png", (long)[[NSDate date] timeIntervalSince1970]] mimeType:@"image/png"];
        }else if([suffix isEqualToString:@"mp4"]){
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%ld.mp4", (long)[[NSDate date] timeIntervalSince1970]] mimeType:@"image/mp4"];
        }else if([suffix isEqualToString:@"wav"]){
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%ld.wav", (long)[[NSDate date] timeIntervalSince1970]] mimeType:@"audio/x-wav"];
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"正在上传"];
        SHOW_WARN_INFO(APP.window, 1.5, @"上传成功");
        if(sucess){
            sucess(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"正在上传"]; 
        SHOW_WARN_INFO(APP.window, 1.5, @"上传失败");
        if(failed){
            failed(nil);
        }
    }];
}


/**
 *  多图上传
 */
+(void)startMultiPartUploadTaskWithURL:(NSString *)url imagesArray:(NSArray *)images compressionRatio:(float)ratio succeedBlock:(void (^)(NSDictionary *dict))succeedBlock failedBlock:(void (^)(NSError *error))failedBlock{
    if (images.count == 0) {
        NSLog(@"图片数组计数为零");
        return;
    }
    for (int i = 0; i < images.count; i++) {
        if (![images[i] isKindOfClass:[UIImage class]]) {
            NSLog(@"images中第%d个元素不是UIImage对象",i+1);
        }
    }
    [[ProgressHUD instance]  showBackProgressHD:YES inView:APP.window info:@"正在上传" ];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //以下三项manager的属性根据需要进行配置
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 0;
        //根据当前系统时间生成图片名称

        NSTimeInterval time =  [[NSDate date] timeIntervalSince1970];
        for (UIImage *image in images) {
            i+= 1;
            NSString *fileName = [NSString stringWithFormat:@"%f%d",time,i];
            NSData *imageData;
            if (ratio > 0.0f && ratio < 1.0f) {
                imageData = UIImageJPEGRepresentation(image, ratio);
            }else{
                imageData = UIImageJPEGRepresentation(image, 1.0f);
            }
//            [formData appendPartWithFileData:imageData name:parameter fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        

        NSLog(@"common post json = %@", responseObject);
          [[ProgressHUD instance]  showBackProgressHD:NO inView:APP.window info:@"正在上传" ];
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failedBlock(error);
            
            NSLog(@"%@",error);
        }
    }];
}

@end
