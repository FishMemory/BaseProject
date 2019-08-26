//
//  EncryptClass.h
//  WenXiaoYou
//
//  Created by 宋亚清 on 16/2/29.
//  Copyright © 2016年 lantuiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptClass : NSString

+(void)EncryptWithMessage:(NSString *)mes Keys:(NSString *)keyS dic:(NSDictionary *)dic;

@end
