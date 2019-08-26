//
//  UIBarButtonItem+Extend.m
//  Carpenter
//
//  Created by 冯成林 on 15/5/11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "UIBarButtonItem+Extend.h"
#import "UIImage+Color.h"

@implementation UIBarButtonItem (Extend)

+(instancetype)barButtonItemWithSize:(CGSize)size target:(id)target selector:(SEL)selector ImgName:(NSString *)imgName titleColor:(UIColor *)Color title:(NSString*)title{
    
    //创建按钮
    UIButton *btn = [[UIButton alloc] init];
   
    //绑定事件
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    btn.frame= (CGRect){CGPointZero,size};
    btn.titleLabel.font = FONT(16);
    //image
    UIImage *image = [UIImage imageNamed:imgName];
    
    [btn setTitleColor:Color forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    //创建
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
   
    return item;
}
+(instancetype)barButtonItemWithSize:(CGSize)size target:(id)target selector:(SEL)selector ImgName:(NSString *)imgName Alignment:(NSInteger)Alignment{
    
    //创建按钮
    UIButton *btn = [[UIButton alloc] init];
//    [btn setTintColor:tintColor];
    //绑定事件
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    btn.frame= (CGRect){CGPointZero,size};
    
    //image
    UIImage *image = [UIImage imageNamed:imgName];
//    UIImage *hlImage = [image imageWithGradientTintColor:hlImageColor];
    
    [btn setImage:image forState:UIControlStateNormal];
//    [btn setImage:hlImage forState:UIControlStateHighlighted];
//    btn.contentMode = UIViewContentModeLeft;
    btn.contentHorizontalAlignment = Alignment;
    //创建
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return item;
}
@end
