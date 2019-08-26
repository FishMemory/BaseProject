//
//  Http.h
//  AESTest
//
//  Created by MichaelTang on 16/3/1.
//  Copyright © 2016年  . All rights reserved.
//

#ifndef Http_h
#define Http_h

@interface Http : NSObject
/**
 *  将任意的json字符串转化成字典或者数组
 *
 *  @param jsonString json串
 *
 *  @return 字段或者数组
 */
+(id)toArrayOrNSDictionaryFromJsonStr:(NSString *)jsonString;
/**
 *  将字典或数组类型（JSON对象）转成Json字符串
 *
 *  @param jsonObj json对象
 *
 *  @return json字符串
 */
+(id)jsonObjToNSString:(id)jsonObj;


+(NSString*) md5:(NSString*)data;

@end

#endif /* Http_h */
