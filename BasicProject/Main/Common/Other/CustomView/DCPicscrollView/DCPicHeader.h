//
//  DCPicHeader.h
//   
//
//  Created by 宋亚清 on 16/3/18.
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCWebImageManager.h"
#import "DCPicScrollView.h"

@interface DCPicHeader : NSObject
@property (strong, nonatomic)  DCPicScrollView  *picView;
/**
 *  创建添加轮播图方法
 *
 *  @param UrlStringArray url数组
 *  @param bgview         要添加哪个view
 */
-(void)addDLScrollWithUrlArray:(NSArray *)UrlStringArray  bgview:(UIView *)bgview frame:(CGRect)picFrame;

-(void)addDLScrolWithUrlArray:(NSArray *)UrlArray  view:(UIView *)bgview;


@end
