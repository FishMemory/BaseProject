//
//  AutoArrange.m
//   
//
//  Created by   on 16/3/16.
//  Copyright © 2016年  . All rights reserved.
//

#import "AutoArrange.h"

@implementation AutoArrange

+ (CGRect )arrangeLabel:(UILabel *)anlabel WithFixedHeight:(CGFloat)height WithfontSize:(CGFloat)fontSize WithString:(NSString *)string{
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(1000, height)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    CGRect labelrect = CGRectMake(anlabel.frame.origin.x, anlabel.frame.origin.y, rect.size.width, height);
    return labelrect;
}

+ (CGRect)arrangeLabel:(UILabel *)anlabel WithFixedWidth:(CGFloat)width WithfontSize:(CGFloat)fontSize WithString:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 1000)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    CGRect labelrect = CGRectMake(anlabel.frame.origin.x, anlabel.frame.origin.y, width, rect.size.height);
    
    return labelrect;
}


@end
