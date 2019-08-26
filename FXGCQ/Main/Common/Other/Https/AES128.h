//
//  AES128.h
//  AESTest
//
//  Created by   on 16/2/29.
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonCryptor.h>

#import "GTMBase64.h"

#define KEY @" appkey"
#define VECTOR @"d2VueGlhb3lvdXZlY3Rvcg=="

@interface AES128 : NSObject


+(NSData*)safeUrlBase64Decode:(NSString*)safeUrlbase64Str;
+(NSString*)safeUrlBase64Encode:(NSData*)data;

/**
 *  AES 加密
 *
 *  @param plainText 原文
 *  @param key       加密私钥KEY
 *
 *  @return 密文
 */

+(NSString *)AES128Encrypt:(NSString *)plainText withKey:(NSString *)key;

/**
 *  AES 解密
 *
 *  @param encryptText 密文
 *  @param key         解密私钥
 *
 *  @return 明文
 */
+(NSString *)AES128Decrypt:(NSString *)encryptText withKey:(NSString *)key;
+(BOOL)validKey:(NSString*)key;

@end
