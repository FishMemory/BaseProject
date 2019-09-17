//
//  UIBarButtonItem+Extend.m
//  Carpenter
//
//  Created by 冯成林 on 15/5/11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "UIBarButtonItem+Extend.h"
#import "UIImage+Color.h"
@interface UIBarButtonItem()
@property (nonatomic) BarButtonItemBlock barButtonItemBlock;
@end
@implementation UIBarButtonItem (Extend)

+(instancetype)barButtonItemWithImage:(NSString *)image andBarButtonItemBlock:(BarButtonItemBlock)barButtonItemBlock
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //                     buttonWithImageName:image];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.frame = CGRectMake(0, 0, 20, 44);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    item.barButtonItemBlock = barButtonItemBlock;
    
    [btn addTarget:item action:@selector(clickItem) forControlEvents:UIControlEventTouchUpInside];
    return item;
}

+(instancetype)barButtonItemWithTitle:(NSString *)title andBarButtonItemBlock:(BarButtonItemBlock)barButtonItemBlock
{
    //默认是白色文字
    return [self barButtonItemWithTitle:title titleColor:[UIColor whiteColor] andBarButtonItemBlock:barButtonItemBlock];
}

+(instancetype)barButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor andBarButtonItemBlock:(BarButtonItemBlock)barButtonItemBlock
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    [item setTarget:item];
    [item setAction:@selector(clickItem)];
    item.barButtonItemBlock = barButtonItemBlock;
    item.tintColor = titleColor;
    return item;
}
- (void)clickItem
{
    
    MJWeakSelf
    if (weakSelf.barButtonItemBlock) {
        weakSelf.barButtonItemBlock();
    }
}



static void *key = &key;
-(void)setBarButtonItemBlock:(BarButtonItemBlock)barButtonItemBlock
{
    objc_setAssociatedObject(self, & key, barButtonItemBlock, OBJC_ASSOCIATION_COPY);
}
-(BarButtonItemBlock)barButtonItemBlock
{
    return objc_getAssociatedObject(self, &key);
}


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
