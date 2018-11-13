//
//  UILabel+Factory.h
//  ctoffice
//
//  Created by TangShiLei on 13-9-25.
//  Copyright (c) 2013年 xugang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Factory)
/**
 *  初始化label 自设置属性
 *
 *  @param frame   label frame
 *  @param text    显示文字
 *  @param font    字体
 *  @param color   字体颜色
 *  @param bgColor 背景色
 *
 *  @return 返回一个UILabel
 */
+(UILabel*)labelWithFrame:(CGRect)frame withText:(NSString*)text withFont:(UIFont*)font withTextColor:(UIColor*)color withBackgroundColor:(UIColor*)bgColor;

- (UILabel * )StringFontSizeNSRange:(NSRange )fontRange size:(CGFloat )sizeOfFont StringFontColor:(UIColor *)stringColor StringColorRange:(NSRange )colorRange;

@end


