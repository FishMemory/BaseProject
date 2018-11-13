//
//  AES128.m
//  AESTest
//
//  Created by   on 16/2/29.
//  Copyright © 2016年  . All rights reserved.
//

#import "AES128.h"


@implementation AES128

/// 将saveBase64编码中的"-"，"_"字符串转换成"+"，"/"，字符串长度余4倍的位补"="
+(NSData*)safeUrlBase64Decode:(NSString*)safeUrlbase64Str
{
    // '-' -> '+'
    // '_' -> '/'
    // 不足4倍长度，补'='
    NSMutableString * base64Str = [[NSMutableString alloc]initWithString:safeUrlbase64Str];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSInteger mod4 = base64Str.length % 4;
    
    if(mod4 > 0)
    
    [base64Str appendString:[@"====" substringToIndex:(4 - mod4)]];
    
//    NSLog(@"Base64原文：%@", base64Str);
    
    NSData * utedData = [base64Str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData * decodedDAta = [GTMBase64 decodeData:utedData];
    
    return decodedDAta;
    
}

/// 因为Base64编码中包含有+,/,=这些不安全的URL字符串，所以要进行换字符
+(NSString*)safeUrlBase64Encode:(NSData*)data
{
    // '+' -> '-'
    // '/' -> '_'
    // '=' -> ''
    NSString * base64Str = [GTMBase64 stringByEncodingData:data];
    NSMutableString * safeBase64Str = [[NSMutableString alloc]initWithString:base64Str];
    safeBase64Str = (NSMutableString * )[safeBase64Str stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    safeBase64Str = (NSMutableString * )[safeBase64Str stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    safeBase64Str = (NSMutableString * )[safeBase64Str stringByReplacingOccurrencesOfString:@"=" withString:@""];
//    NSLog(@"safeBase64编码：%@", safeBase64Str);
    return safeBase64Str;
}

#pragma AES128位CBC NOPadding加密
+(NSString *)AES128Encrypt:(NSString *)plainText withKey:(NSString *)key
{
    
    if( ![self validKey:key] ){
        return nil;
    }
    // key密钥初始化
    
    // 向量初始化
    NSString * ivString = [GTMBase64 decodeBase64String:VECTOR];
//    NSLog(@" vector = %@", ivString);
    
    if(ivString.length != 16){
        return nil;
    }
    //
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    // 如果明文不足AES128位（16字节），则要尾部补0
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    
    unsigned long newSize = 0;
    
    // 不足16字节，少diff个
    if(diff > 0)
    {
        // 补diff个字节
        newSize = dataLength + diff;
//        NSLog(@"diff is %d",diff);
    }
    
    char dataPtr[newSize];
    // 尾部补0
    memset(dataPtr, 0, sizeof(dataPtr));
    memcpy(dataPtr, [data bytes], data.length);

    // 密文缓存，密文要比明文多AES128位，即16字节
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          [KEY UTF8String],
                                          kCCKeySizeAES128,
                                          [ivString UTF8String],
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    // 转码成功
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        NSString * base64Str = [self safeUrlBase64Encode:resultData];
//        NSLog(@" safe_base64 = %@",base64Str);
        return base64Str;
    }
    free(buffer);
    return nil;
}


#pragma AES128位CBC NOPadding解密
+(NSString *)AES128Decrypt:(NSString *)encryptText withKey:(NSString *)key
{
    
    if( ![self validKey:key] ){
        return nil;
    }
    
    // 向量初始化
    NSString * ivString = [GTMBase64 decodeBase64String:VECTOR];
    
//    NSLog(@" vector = %@", ivString);
    
    if(ivString.length != 16){
        return nil;
    }
    

    // 密文先base64解码
    NSData *data = [self safeUrlBase64Decode:encryptText];
    // 密文长度
    NSUInteger dataLength = [data length];
    // 缓存
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          [KEY UTF8String],
                                          kCCBlockSizeAES128,
                                          [ivString UTF8String],
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        NSString *decoded=[[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        
        // AES加密时，如果没有按128位对齐，可能会在原文后面添加\0作为占位符
        // 而iOS要求比较严格，JSON串中不能有\0占位符删除之
        NSString* string = [decoded stringByReplacingOccurrencesOfString:@"\0" withString:@""];
        
        if(string==nil || string.length==0){
            return nil;
        }
        return string;
    }
    
    free(buffer);
    return nil;
    
}

+(BOOL)validKey:(NSString*)key
{
    if( key== nil || key.length !=16 ){
        return NO;
    }
    return YES;
}
@end

