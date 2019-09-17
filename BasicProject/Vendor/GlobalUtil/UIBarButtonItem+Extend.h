//
//  UIBarButtonItem+Extend.h
//  Carpenter
//
//  Created by 冯成林 on 15/5/11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extend)
typedef void(^BarButtonItemBlock) (void);

/**
 *  用图片创建barButtonItem
 */
+ (instancetype)barButtonItemWithImage:(NSString *)image andBarButtonItemBlock:(BarButtonItemBlock)barButtonItemBlock;

/**
 *  纯文字创建barButtonItem 白色文字
 */
+ (instancetype)barButtonItemWithTitle:(NSString *)title andBarButtonItemBlock:(BarButtonItemBlock)barButtonItemBlock;

/**
 *  纯文字创建barButtonItem 自定义文字
 */
+(instancetype)barButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor andBarButtonItemBlock:(BarButtonItemBlock)barButtonItemBlock;

+(instancetype)barButtonItemWithSize:(CGSize)size target:(id)target selector:(SEL)selector ImgName:(NSString *)imgName titleColor:(UIColor *)Color title:(NSString*)title;

+(instancetype)barButtonItemWithSize:(CGSize)size target:(id)target selector:(SEL)selector ImgName:(NSString *)imgName Alignment:(NSInteger)Alignment;
@end
