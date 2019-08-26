//
//  ShareModel.h
//  WenXiaoYou
//
//  Created by 宋亚清 on 16/6/26.
//  Copyright © 2016年 lantuiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareModel : NSObject
@property (copy, nonatomic) UIImage * headerImage;/**< 头像 >*/
@property (copy, nonatomic) NSString  *title;   /**< 分享标题 >*/
@property (copy, nonatomic) NSString  *shareUrl;/**< 分享网址 >*/
@property (assign, nonatomic) NSInteger share;    /**< 1可分享 0 不可分享 >*/
@property (copy, nonatomic) NSString  *desc;    /**< 分享内容 >*/
@property (copy, nonatomic) NSString  *thumbUrl;/**< 缩略图 >*/
@end
