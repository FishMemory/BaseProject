//
//  DeleLine.h
//   
//
//  Created by   on 16/3/16.
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeleLine : NSObject
/**
 *  删除导航栏底部黑色线
 *
 *  @param navigationController
 *
 *  @return
 */
+ (instancetype)deleteNavigateLine:(UINavigationController * )navigationController;
/**
 *  增加底部导航栏黑色线
 *
 *  @param navigationController
 *
 *  @return
 */
+ (instancetype)addNavigateLine:(UINavigationController *)navigationController;
@end
