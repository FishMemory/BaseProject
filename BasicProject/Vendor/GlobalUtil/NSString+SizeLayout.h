//
//  NSString+SizeLayout.h
//  iHummingBird
//
//  Created by Tang Shilei on 14-10-4.
//  Copyright (c) 2014年 HummingBird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SizeLayout)
/**
 *  计算字符长度
 *
 *  @param size size(MAXFLOAT,hieght)
 *  @param font size
 *
 *  @return <#return value description#>
 */
- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;

/**
 *  计算带行间距的高度  返回高度
 *
 *  @param lineSpace 行间距
 *  @param font      字体
 *  @param width     文本宽度
 *
 *  @return height
 */
-(CGFloat)getSpaceLabelHeight:(CGFloat )lineSpace withFont:(UIFont*)font withWidth:(CGFloat)width;
@end
