
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
        // 宋亚清Tang add 2016.07.07 for https
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

+(void)get:(NSString*)url showBackProgressHD:(BOOL)show showError:(BOOL)showErrorToast success:(Success)success networkErroBlock:(ErrorBlock)networkError
{
    if ([NetworkUtils checkNetWork:nil]){
    }else{
        [[ProgressHUD instance] showBackProgressHD:show inView:APP.window info:@""];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.requestSerializer.timeoutInterval = 15.0;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        // 将_id和url拼接
        NSString *urlString = url;
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        //        NSLog(@"####>>>> 请求的 urlStr = %@",urlString);
        
        [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary* respObj = responseObject;
            
            //  隐藏进度圈
            [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"Loading..."];
            
            // API接口返回错误
            NSString* code = nil;
            NSString *error = nil;
            @try {
                code = [respObj objectForKey:@"code"];
                error = [respObj objectForKey:@"message"];
                error =  error.length > 0 ? error : [responseObject objectForKey:@"msg"];
            } @catch (NSException *exception) {
                
            }
            if ([code intValue] != 200) {
#ifdef DEBUG  // 开发
                SHOW_WARN_INFO(APP.window, 1.5, error);
#endif
            }
            if(success){
                success([responseObject objectForKey:@"content"]);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
            
            if(showErrorToast)
                SHOW_WARN_INFO(APP.window, 2.5,@"Network connection error");
            
            if(networkError)
                networkError(task, error);
        }];
    }
}



+(void)post:(NSString*)url  showBackProgressHD:(BOOL)show  showError:(BOOL)showErrorToast dataDic:(NSDictionary*)dataDic
    success:(Success)success networkErroBlock:(ErrorBlock)networkError
{
    if ([NetworkUtils checkNetWork:nil]){
    }else{
        if (show) {
            [[ProgressHUD instance] showBackProgressHD:show inView:APP.window info:@"Loading..."];
        }
        if (!(url.length > 0)) {
            [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"Loading..."];
            return;
        }
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 15.0;
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        [manager.requestSerializer setValue:APP.token forHTTPHeaderField:@"token"];
        //        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];
        
        NSMutableDictionary *sendParam = [NSMutableDictionary dictionaryWithDictionary:dataDic];
        //        [sendParam setObjectCheck:APP.curUserId forKey:@"uid"];
        //        NSLog(@"####>>>>上传数据 %@", dataDic);
        [manager POST:url parameters:sendParam progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //  隐藏进度圈
            if (show) {
                [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"Loading..."];
            }
            //  NSLog(@"服务器响应数据 %@",responseObject);
            // API接口返回错误
            id code = nil;
            
            NSString *error = nil;
            @try {
                code = [responseObject objectForKeyCheck:@"code"];
                error = [responseObject objectForKeyCheck:@"msg"];
                error =  error.length > 0 ? error : [responseObject objectForKeyCheck:@"message"];
            } @catch (NSException *exception) {
            }
            // code返回非200,说明接口返回错误
            if (showErrorToast && [code intValue] != 200) {
                if(networkError){
                    SHOW_WARN_INFO(APP.window, 1.5,error);
                    networkError(nil, nil);
                }
                
#ifdef DEBUG  // 开发
                SHOW_WARN_INFO(APP.window, 1.5, error);
#endif
            }else{
                if(success){
                    success([responseObject objectForKey:@"content"]);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"Loading..."];
            if(showErrorToast)
                SHOW_WARN_INFO(APP.window, 1.5, @"网络错误");
            
            NSLog(@"网络请求错误信息 %@",error);
            if(networkError)
                networkError(task, error);
        }];
    }
}


//我的shop编辑商品post请求,传参数array
+(void)shopPost:(NSString*)url  showBackProgressHD:(BOOL)show  showError:(BOOL)showErrorToast dataDic:(id)dataDic
        success:(Success)success networkErroBlock:(ErrorBlock)networkError
{
    if ([NetworkUtils checkNetWork:nil]){
    }else{
        
        [[ProgressHUD instance] showBackProgressHD:show inView:APP.window info:@"Loading..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 15.0;
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        
        NSLog(@"####>>>>上传数据 %@", dataDic);
        
        [manager POST:url parameters:dataDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //  隐藏进度圈
            [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"Loading..."];
            
            //              NSLog(@"服务器响应数据 %@",responseObject);
            // API接口返回错误
            id code = nil;
            
            NSString *error = nil;
            @try {
                code = [responseObject objectForKeyCheck:@"code"];
                error = [responseObject objectForKeyCheck:@"msg"];
                error =  error.length > 0 ? error : [responseObject objectForKeyCheck:@"message"];
            } @catch (NSException *exception) {
            }
            // code返回非200,说明接口返回错误
            if ([code intValue] != 200) {
#ifdef DEBUG  // 开发
                SHOW_WARN_INFO(APP.window, 1.5, error);
#endif
            }
            if(success){
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"Loading..."];
            if(showErrorToast)
                SHOW_WARN_INFO(APP.window, 1.5, @"Network connection error");
            
            NSLog(@"网络请求错误信息 %@",error.userInfo);
            if(networkError)
                networkError(task, error);
        }];
    }
}


+ (void)postNetworkDataSuccess:(Success)success failure:(ErrorBlock)failure withUrl:(NSString *)urlStr withParameters:(NSDictionary *)dict {
    
    AFHTTPSessionManager *afHttpSessionManager = [AFHTTPSessionManager manager];
    
    afHttpSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    afHttpSessionManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    afHttpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    afHttpSessionManager.requestSerializer= [AFHTTPRequestSerializer serializer];
    [afHttpSessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"If-None-Match"];
    [afHttpSessionManager.requestSerializer setValue:APP.token forHTTPHeaderField:@"token"];
    [afHttpSessionManager POST:urlStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //回调是在主线程中，可以直接更新UI
        NSLog(@"%@", [NSThread currentThread]);
        //        NSLog(@"返回data %@",responseObject);
        if(success) success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        NSLog(@"get failure:%@",error);
    }];
}


+(void)uploadFileWithFormat:(NSData*)data dic:(NSDictionary*)dict url:(NSString*)url format:(NSString *)suffix success:(Success)sucess failed:(APIErrorBlock)failed
{
    if(suffix == nil){
        SHOW_WARN_INFO(APP.window, 1.5, @"指定上传格式format");
        if(failed){
            failed(nil);
        }
        return;
    }
    [[ProgressHUD instance] showBackProgressHD:YES inView:APP.window info:@"uploading.."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if([suffix isEqualToString:@"jpg"]){
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%ld.jpg", (long)[[NSDate date] timeIntervalSince1970]] mimeType:@"image/jpeg"];
        }else if([suffix isEqualToString:@"png"]){
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%ld.png", (long)[[NSDate date] timeIntervalSince1970]] mimeType:@"image/png"];
        }else if([suffix isEqualToString:@"mp4"]){
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%ld.mp4", (long)[[NSDate date] timeIntervalSince1970]] mimeType:@"image/mp4"];
        }else if([suffix isEqualToString:@"wav"]){
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%ld.wav", (long)[[NSDate date] timeIntervalSince1970]] mimeType:@"audio/x-wav"];
        } else if([suffix isEqualToString:@"mp3"]){
            [formData appendPartWithFileData:data name:@"aFile" fileName:[NSString stringWithFormat:@"%ld.mp3", (long)[[NSDate date] timeIntervalSince1970]] mimeType:@"multipart/form-data"];
            //            [formData appendPartWithFormData:data name:[NSString stringWithFormat:@"%ld.mp3", (long)[[NSDate date] timeIntervalSince1970]]];
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"uploading.."];
        SHOW_WARN_INFO(APP.window, 1.5, @"上传成功");
        if(sucess){
            sucess(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@"uploading.."];
        
        SHOW_WARN_INFO(APP.window, 1.5, @"上传失败");
        if(failed){
            failed(nil);
        }
    }];
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
