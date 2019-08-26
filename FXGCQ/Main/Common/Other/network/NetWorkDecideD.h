//
//  NetWorkDecideD.h
//  北大爱思唯尔
//
//  Created by 宋亚清 on 14-10-14.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkDecideD : NSObject
+(void)getNetwork;
+ (BOOL) IsEnableWIFI;
+ (BOOL) IsEnable3G;
+ (BOOL) IsEnableNonNetWork;
@end
