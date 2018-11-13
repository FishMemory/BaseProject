//
//  AutoArrange.h
//   
//
//  Created by   on 16/3/16.
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoArrange : NSObject

/**
 *  根据内容自适应宽度
 *
 *  @param anlabel  需要处理的label
 *  @param height   固定的高度
 *  @param fontSize label上字体的大小
 *  @param string   label上需要显示字符串
 *
 *  @return 返回处理过后的label的frame
 */
+ (CGRect )arrangeLabel:(UILabel *)anlabel WithFixedHeight:(CGFloat)height WithfontSize:(CGFloat)fontSize WithString:(NSString *)string;

/**
 *  根据内容自适应高度
 *
 *  @param anlabel  需要处理的label
 *  @param width    固定的高度
 *  @param fontSize label上字体的大小
 *  @param string   label上需要显示字符串
 *
 *  @return 返回处理过后的label的frame
 */
+ (CGRect )arrangeLabel:(UILabel *)anlabel WithFixedWidth:(CGFloat)width WithfontSize:(CGFloat)fontSize WithString:(NSString *)string;

@end
