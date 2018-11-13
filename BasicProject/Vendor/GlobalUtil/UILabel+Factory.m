//
//  UILabel+Factory.m
//  ctoffice
//
//  Created by TangShiLei on 13-9-25.
//  Copyright (c) 2013年 xugang. All rights reserved.
//

#import "UILabel+Factory.h"
//#import <CoreText/CoreText.h>
@implementation UILabel (Factory)


+(UILabel*)labelWithFrame:(CGRect)frame withText:(NSString *)text withFont:(UIFont *)font withTextColor:(UIColor *)color withBackgroundColor:(UIColor *)bgColor
{
    
    UILabel *label=[[UILabel alloc]initWithFrame:frame];
    label.text=text;
    label.font=font;
    label.textColor=color;
    label.backgroundColor=bgColor;
    return label;
}

+(void)loadFontResource:(NSString *)name fontType:(NSString *)type{
//    NSURL *fontUrl = [[NSBundle mainBundle] URLForResource:name withExtension:type];
//    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
//    CGFontRef newFont = CGFontCreateWithDataProvider(fontDataProvider);
//    CGDataProviderRelease(fontDataProvider);
//    CFErrorRef error = NULL;
//    CTFontManagerRegisterGraphicsFont(newFont, &error);
//    CGFontRelease(newFont);
}

- (UILabel *)StringFontSizeNSRange:(NSRange )fontRange size:(CGFloat)sizeOfFont StringFontColor:(UIColor *)stringColor StringColorRange:(NSRange )colorRange{
    if (self.text.length > 0) {
        NSMutableAttributedString * attrbuteStr = [[NSMutableAttributedString alloc]initWithString:self.text];
        UIFont * font = [UIFont systemFontOfSize:sizeOfFont];
        
        if (NSEqualRanges(fontRange, NSMakeRange(0, 0))) {
        }else{
            [attrbuteStr addAttribute:NSFontAttributeName value:font range:fontRange];
        }
        if (stringColor != nil) {
            UIColor * changeColor = stringColor;
            if (NSEqualRanges(colorRange, NSMakeRange(0, 0))) {
            }else{
                [attrbuteStr addAttribute:NSForegroundColorAttributeName value:changeColor range:colorRange];
            }
        }else{
        }
        [self setAttributedText:attrbuteStr];
        return self;
    }else{
        return self;
    }
}

@end
