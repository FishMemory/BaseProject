//
//  UploadFile.m
//   
//
//  Created by 宋亚清 on 2017/2/9.
//  Copyright © 2017年  . All rights reserved.
//

#import "UploadFile.h"

@implementation UploadFile
// 拼接字符串
static NSString *boundaryStr = @"--";   // 分隔字符串
static NSString *randomIDStr;           // 本次上传标示字符串
static NSString *uploadID;              // 上传(php)脚本中，接收文件字段

static NSString *randomIDStr = @"michaeltest";
static NSString *uploadID = @"uploadFile";

#pragma mark - 私有方法
+ (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"--%@\r\n", randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", uploadID, uploadFile];
    [strM appendFormat:@"Content-Type: %@\n\n", mimeType];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

+ (NSString *)bottomString
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\r\n", boundaryStr, randomIDStr];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", boundaryStr, randomIDStr];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

#pragma mark - 上传文件
+ (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data dir:(NSString*)dname
{
    NSMutableData *dataM = [NSMutableData data];
    if(dname && [dname length] > 0){
        [dataM appendData:[[NSString stringWithFormat:@"dir=%@&", dname] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [dataM appendData:[@"file=" dataUsingEncoding:NSUTF8StringEncoding]];
    [dataM appendData:data];
    
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0f];
    
    // dataM出了作用域就会被释放,因此不用copy
    request.HTTPBody = dataM;
    
    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";
    
    // 3> 设置Content-Length
//    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
//    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    
//    [request setValue:@"application/x-www-form-data" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:[NSString stringWithFormat:@"%@", APP.curUserId] forHTTPHeaderField:@"x-header-uid"];
//    [request setValue:APP.token forHTTPHeaderField:@"x-header-token"];
//    [request setValue:@"" forHTTPHeaderField:@"x-header-sign"];
    
    // ios-1.0后面的版本号和App内的版本号一致
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString * version = [NSString stringWithFormat:@"ios-%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
//    [request setValue:version forHTTPHeaderField:@"x-header-version"];
    
    
    // 4> 设置Content-Type
    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    // 3> 连接服务器发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", result);
    }];
}



@end
