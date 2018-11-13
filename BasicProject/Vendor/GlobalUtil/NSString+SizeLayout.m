//
//  m
//  iHummingBird
//
//  Created by Tang Shilei on 14-10-4.
//  Copyright (c) 2014年 HummingBird. All rights reserved.
//

#import "NSString+SizeLayout.h"

@implementation NSString (SizeLayout)

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font {
    CGSize expectedLabelSize = CGSizeZero;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        
    }else {
        expectedLabelSize = [self sizeWithFont:font  constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}

-(CGFloat)getSpaceLabelHeight:(CGFloat )lineSpace withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;  //
    paraStyle.alignment = NSTextAlignmentLeft;  //
    paraStyle.lineSpacing = lineSpace;  //设置行间距
    paraStyle.hyphenationFactor = 1;  // 连字属性
    paraStyle.firstLineHeadIndent = 0.0;  // //首行缩进
    paraStyle.paragraphSpacingBefore = 0.0;  // 段首行空白空
    paraStyle.headIndent = 0; // 整体缩进(首行除外)
    paraStyle.tailIndent = 0; //
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

@end
