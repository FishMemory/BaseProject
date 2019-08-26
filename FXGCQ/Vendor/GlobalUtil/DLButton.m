//
//  DLButton.m
//  DLKit
//
//  Created by XueYulun on 15/3/25.
//  Copyright (c) 2015年 X. All rights reserved.
//

#import "DLButton.h"

@implementation DLButton


+ (UIButton *)buttonType: (UIButtonType)type frame: (CGRect)frame  titleColor: (UIColor *)color backGroundImage: (UIImage *)BGImage highLightImage: (UIImage *)highLightImage target: (id)object Selector: (SEL)sec selectorState: (UIControlEvents)buttonEvent title: (NSString *)title {
    
    UIButton * button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setBackgroundImage:BGImage forState:UIControlStateNormal];
    [button setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
    [button addTarget:object action:sec forControlEvents:buttonEvent];
    return button;
}
+ (UIButton *)buttonType: (UIButtonType)type frame: (CGRect)frame  titleColor: (UIColor *)color backGroundImage: (UIImage *)BGImage target: (id)object Selector: (SEL)sec selectorState: (UIControlEvents)buttonEvent title: (NSString *)title cornerRadius:(CGFloat)radius{
    UIButton * button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setBackgroundImage:BGImage forState:UIControlStateNormal];
    [button addTarget:object action:sec forControlEvents:buttonEvent];
    if (radius > 0) {
        button.layer.cornerRadius =radius;
        button.layer.masksToBounds = YES;
    }
    return button;
}

+ (UIButton *)buttonType: (UIButtonType)type frame: (CGRect)frame  titleColor: (UIColor *)color  target: (id)object Selector: (SEL)sec selectorState: (UIControlEvents)buttonEvent title: (NSString *)title cornerRadius:(CGFloat)radius{
    
    UIButton * button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:object action:sec forControlEvents:buttonEvent];
    if (radius > 0) {
        button.layer.cornerRadius =radius;
        button.layer.masksToBounds = YES;
    }
    return button;
}

+ (UIButton *)buttonType:(UIButtonType)type frame:(CGRect)frame  tintColor:(UIColor *)color fontSize:(CGFloat)size image:(NSString*)imageName{
    
    UIButton * button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button setImage:ImageNamed(imageName) forState:UIControlStateNormal];
//    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTintColor:color];
     button.titleLabel.font = FONT(size);
    return button;
}

+ (UIButton *)buttonType: (UIButtonType)type frame: (CGRect)frame  titleColor: (UIColor *)color title: (NSString *)title cornerRadius:(CGFloat)radius{
    
    UIButton * button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    
    if (radius > 0) {
        button.layer.cornerRadius =radius;
        button.layer.masksToBounds = YES;
    }
    return button;
}


+(NSMutableArray *) setButtonArrayName:(NSArray *)nameArray selectImageArray:(NSArray *)selectImageArray image:(NSArray *)imageArray fontSize:(CGFloat)fontSize
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i< nameArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:COL_THEME_BLUE forState:UIControlStateSelected];
        [btn setTitleColor:rgb(102, 102, 102) forState:UIControlStateNormal];
//        CGFloat btnWidth =  SCREEN_WIDTH/nameArray.count;
        NSString *titleStr = [nameArray objectAtIndexCheck:i];
//        CGSize titleSize  = [titleStr calculateSize:CGSizeMake(MAXFLOAT, fontSize+1) font:FONT(fontSize)];
        NSString *imageName =  [imageArray objectAtIndexCheck:i];
        if (imageName) {
            [btn setBackgroundImage:ImageNamed(imageName) forState:UIControlStateNormal];
        } 
        NSString *selecetName =  [selectImageArray objectAtIndexCheck:i];
        if (selecetName) {
            [btn setBackgroundImage:ImageNamed(selecetName) forState:UIControlStateSelected];
        }
        [btn setTitle:titleStr forState:UIControlStateNormal];
       
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, (btnWidth-titleSize.width)/2.0, 0, (btnWidth-titleSize.width)/2.0)];
        
         btn.titleLabel.font = FONT(fontSize);
        [array addObject:btn];
    }
    return array;
}


@end
