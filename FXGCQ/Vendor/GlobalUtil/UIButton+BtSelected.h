//
//  UIButton+BtSelected.h
//  Whereedu
//
//  Created by   on 16/1/31.
//  Copyright © 2016年  . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BtSelected)
/**
 *  选中状态时button背景颜色
 *
 *  @param backgroundColor 选中状态的颜色
 *  @param state           状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
/**
 *  将颜色转成图片
 *
 *  @param color 颜色
 *
 *  @return 返回图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
