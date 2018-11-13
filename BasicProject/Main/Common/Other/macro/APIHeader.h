//
//  APIHeader.h
//   
//
//  Created by   on 16/2/24.
//  Copyright © 2016年  . All rights reserved.
//  接口地址定义页面

#ifndef Project_APIHeader_h_h

#define Project_APIHeader_h_h
// 服务器域名  正式 / 测试 / 开发
#ifdef DEBUG  // 开发
#define ServiceHead  @""
#elif defined PROD // 预发布
#define ServiceHead @"" // 预发布
#else // 发布

#define ServiceHead @""  // 发布
#endif
//



#endif /* APIHeader_h */
