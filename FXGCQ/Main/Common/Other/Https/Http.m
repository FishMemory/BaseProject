//
//  Http.m
//  AESTest
//
//  Created by MichaelTang on 16/3/1.
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>

#import "Http.h"

#import "AES128.h"

#import "JSONKit.h"

@implementation Http

#pragma - 将JSON字符串转成字典或数组类型(JSON对象) -

+(id)toArrayOrNSDictionaryFromJsonStr:(NSString *)jsonString{
    NSError *error = nil;

    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    //  json 解析
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject == nil && error){
        NSLog(@" error = %@", error);
        return nil;
    }
    return jsonObject;
}

#pragma - 将字典或数组类型JSON对象转成Json字符串 -

+(id)jsonObjToNSString:(id)jsonObj{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObj
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil && error){
        return nil;
    }
    
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData
                                              encoding:NSUTF8StringEncoding];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\/"
                                                 withString:@"/"];

    return jsonStr;
}



#pragma -- 解码JSON数据 --
+(NSString *)parseData:(NSString *)jsonString
{
    NSLog(@"————————————————————解码开始——————————————————————");
    
    if(jsonString == nil){
        return nil;
    }
    bool isEncode = NO;
    
    NSLog(@" data = %@", jsonString);
    
    // 将JSON字符串转成字典类型
    id jsonObj = [self toArrayOrNSDictionaryFromJsonStr: jsonString];
    
    // 判断JSON的合法性
    NSLog(@" data = %@", [jsonObj valueForKey:@"data"]);
    NSLog(@" timestamp = %@", [jsonObj objectForKey:@"timestamp"]);
    NSLog(@" sign = %@", [jsonObj objectForKey:@"sign"]);
    NSLog(@" encode = %@", [jsonObj objectForKey:@"encode"]);
    
    if([jsonObj objectForKey:@"data"] != nil &&
       [jsonObj objectForKey:@"timestamp"] != nil &&
       [jsonObj objectForKey:@"sign"]!= nil ){
        if([jsonObj objectForKey:@"encode"]!= nil ){
            isEncode = YES;
        }
    }else{
        return nil;
    }
    
    if(!isEncode){
        return nil;
    }
    // 去掉sign进行签名验证
    NSString * json_nosign;
    if(isEncode){
        json_nosign = [NSString stringWithFormat:@"{\"data\":\"%@\",\"encode\":0,\"timestamp\":%@}",[jsonObj objectForKey:@"data"], [jsonObj objectForKey:@"timestamp"]];
    }else{
        //===========================================
        // 因为data数据无法排序的问题，不使用非加密方式传输 =
        //===========================================
        /*
         // 获得data参数值
         json_nosign = [NSString stringWithFormat:@"{\"data\":%@,\"timestamp\":%@}",[self jsonObjToNSString:[jsonObj objectForKey:@"data"]], [jsonObj objectForKey:@"timestamp"]];
         */
    }
    
//    NSLog(@" json_nosign = %@", json_nosign);
    NSString* mysign = [self md5:json_nosign];
    NSLog(@" MD5 = %@", mysign);
    if([[jsonObj objectForKey:@"sign"] isEqualToString:mysign]){
        NSLog(@" 签名一致");
    }else{
        NSLog(@" 签名不一致");
        return nil;
    }
    
    // 签名验证后，根据encode的值决定是否对data进行解密
    if (isEncode) {
        NSString * datadecrypt = [AES128 AES128Decrypt:[jsonObj objectForKey:@"data"]  withKey:KEY];
        // 返回data数据
        return datadecrypt;
    }else{
        return [jsonObj objectForKey:@"data"];
    }
    
    return nil;
}



#pragma -- 解码JSON数据 --

//  解码 json 数据返回为字典类型


+(NSMutableDictionary *)parseDictData:(id)jsonObj
{
//    NSLog(@"————————————————————解码开始——————————————————");
    
    if(jsonObj == nil){
        return nil;
    }
    bool isEncode = NO;
    
    // 判断JSON的合法性
//    NSLog(@" data = %@", [jsonObj valueForKey:@"data"]);
    NSLog(@" timestamp = %@", [jsonObj objectForKey:@"timestamp"]);
    NSLog(@" sign = %@", [jsonObj objectForKey:@"sign"]);
    NSLog(@" encode = %@", [jsonObj objectForKey:@"encode"]);
    
    if([jsonObj objectForKey:@"data"] != nil &&
       [jsonObj objectForKey:@"timestamp"] != nil &&
       [jsonObj objectForKey:@"sign"]!= nil ){
        if([jsonObj objectForKey:@"encode"]!= nil ){
            isEncode = YES;
        }
    }else{
        return nil;
    }
    
    if(!isEncode){
        return nil;
    }
    // 去掉sign进行签名验证
    NSString * json_nosign;
    if(isEncode){
        json_nosign = [NSString stringWithFormat:@"{\"data\":\"%@\",\"encode\":0,\"timestamp\":%@}",[jsonObj objectForKey:@"data"], [jsonObj objectForKey:@"timestamp"]];
    }else{
        //===========================================
        // 因为data数据无法排序的问题，不使用非加密方式传输 =
        //===========================================
        /*
         // 获得data参数值
         json_nosign = [NSString stringWithFormat:@"{\"data\":%@,\"timestamp\":%@}",[self jsonObjToNSString:[jsonObj objectForKey:@"data"]], [jsonObj objectForKey:@"timestamp"]];
         */
    }
    
//    NSLog(@" json_nosign = %@", json_nosign);
    NSString* mysign = [self md5:json_nosign];
//    NSLog(@" MD5 = %@", mysign);
    if([[jsonObj objectForKey:@"sign"] isEqualToString:mysign]){
        
        NSLog(@" 签名一致");
   
    }else{
        
        NSLog(@" 签名不一致");
        return nil;
    }
    
    // 签名验证后，根据encode的值决定是否对data进行解密
    if (isEncode) {
      
        NSString * datadecrypt = [AES128 AES128Decrypt:[jsonObj objectForKey:@"data"]  withKey:KEY];

        
        // 返回data数据
//        NSLog(@"————————————————解码完成————————————————%@",datadecrypt);
        
        NSData * data = [datadecrypt dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableDictionary * d = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        return d;
    }else{
        
        return [jsonObj objectForKey:@"data"];
    }
    return nil;
}



#pragma -- 打包字典数组数据成JSON --

//  打包字典型的原始数据

+(NSDictionary*) packDictData:(NSMutableDictionary *)originalDict isEncode:(BOOL) encode{
    
    NSLog(@"————————————————————打包开始————————————————————");
    
    NSString * originalString = [originalDict JSONString];
    
    NSLog(@" ----- originalDictString =  %@",originalString);
    
    NSString * aesString;
    
    if (encode) {
        aesString  = (NSString *)[AES128 AES128Encrypt:originalString withKey:KEY];
    }
    
    NSLog(@" aesString = %@",aesString);
    
//    获得时间戳
    UInt64 timeStamp = [[NSDate date] timeIntervalSince1970];
    
    
    //  升序排序
    // 去掉sign进行签名验证
    NSString * json_str;
    if(encode){
        json_str = [NSString stringWithFormat:@"{\"data\":\"%@\",\"encode\":0,\"timestamp\":%llu}",aesString, timeStamp];
    }else{
        json_str = [NSString stringWithFormat:@"{\"data\":%@,\"timestamp\":%llu}",originalString, timeStamp];
    }
    
    //  生成签名
    NSLog(@" json_nosign = %@", json_str);
    
    NSString * sign = [self md5:json_str];

    NSLog(@" MD5 = %@", sign);
    
    // 打包数据,添加签名
    if(encode){
        json_str = [NSString stringWithFormat:@"{\"data\":\"%@\",\"encode\":0,\"timestamp\":%llu,\"sign\":\"%@\"}",aesString, timeStamp, sign];
    }else{
        json_str = [NSString stringWithFormat:@"{\"data\":%@,\"timestamp\":%llu,\"sign\":\"%@\"}",originalString, timeStamp, sign];
    }
    
    NSLog(@" json_str = %@", json_str);
    
    id result = [json_str objectFromJSONString];
    
//    NSLog(@"≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ result = %@", result);

    NSLog(@"————————————————————————打包完成————————————————————————");
    
    return result;
}


//  md5加密

+(NSString*) md5:(NSString*)data
{
    const char *cStr = [data UTF8String];
    
    unsigned char digest[16];
    
    CC_MD5( cStr, (int)strlen(cStr), digest);
    
    NSMutableString *hash = [NSMutableString string];
    
    for(int i= 0 ;i < 16;i++)
    {
        [hash appendFormat:@"%02X",digest[i]];
    }
    return [hash lowercaseString];
}

@end
