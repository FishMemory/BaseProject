//
//  DLLabel.m
//  DLKit
//
//  Created by XueYulun on 15/3/25.
//  Copyright (c) 2015年 X. All rights reserved.
//

#import "DLLabel.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation DLLabel

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
}

- (id)init {
    self = [super init];
    
    if (self)
    {
        [self commonInit];
    }
    return self;
}

-(void)SetBackViews:(UIView *)superViews
{
    self.nameSize = [self.text  calculateSize:CGSizeMake(MAXFLOAT,self.height) font:self.font];
    self.nameSizeH = [self.text  calculateSize:CGSizeMake(self.width, MAXFLOAT) font:self.font];
    self.backView = [[UIView alloc]initWithFrame:FRAME(self.left-2,self.top+(20-self.nameSizeH.height)/2.0,self.nameSize.width+4,self.nameSizeH.height)];
//    self.backView.backgroundColor = rgba(0, 0, 0, 0.3);
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0,0,self.backView.width, self.nameSizeH.height);
//    gradient.colors = [NSArray arrayWithObjects: (id)RGBA(0,0, 0,0).CGColor,(id)RGBA(0, 0,0,0.16).CGColor,(id)RGBA(0, 0,0,0.27).CGColor, (id)RGBA(0, 0,0,0.17).CGColor, (id)RGBA(0, 0,0,0.0).CGColor,nil];
    gradient.colors = [NSArray arrayWithObjects:(id)RGBA(0,0, 0,0.05).CGColor,(id)RGBA(0,0, 0,0.25).CGColor,(id)RGBA(0,0, 0,0.05).CGColor,nil];
    self.backView.alpha = 0.50;
    [self.backView.layer insertSublayer:gradient atIndex:0];
    [superViews insertSubview:self.backView belowSubview:self];
    
}

/**
 设置字体阴影
 */
-(void)setFontShadow
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.layer.shadowOffset = CGSizeMake(0,0);
    
    self.layer.shadowOpacity = 1.0;
    
    self.layer.shadowRadius = 0.8;
    
    self.clipsToBounds = NO;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (id)initWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color {
    return [self initWithText:text font:font textColor:color backgroundColor:[UIColor clearColor]];
}

- (id)initWithText:(NSString *)text  font:(UIFont *)font  textColor:(UIColor *)color Frame:(CGRect)frame {
    self = [super init];
    if (self)
    {
        self.textColor = color;
        [self setText:text font:font];
        self.frame = frame;
    }
    return self;
}

- (id)initWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor {
    self = [super init];
    if (self)
    {
        self.textColor = color;
        self.backgroundColor = backgroundColor;
        
        [self setText:text font:font];
    }
    return self;
}
-(CGSize)getFontSize{
     CGSize size = [self.text sizeWithFont:self.font];
     [self sizeToFit];
    return size;
}
- (void)setText:(NSString *)text font:(UIFont *)font {
    self.text = text;
    self.font = font;
    CGSize size = [text sizeWithFont:font];
    self.frame = CGRectMake(0, 0, size.width, size.height);
    [self sizeToFit];
}
+(UILabel *)creatLabel:(UIFont *)font frame:(CGRect)frame textColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = font;
    return label;
}
- (UILabel *)creatWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = color;
    label.font = font;
    label.text = text;
    return label;
}
- (UILabel *)creatWithText:(NSString *)text Frame:(CGRect)frame{
    UILabel *label = [self creatWithText:text font:FONT_DETAIL textColor:[UIColor blackColor]];
    label.frame =  frame;
    return label;
}
- (UILabel *)creatWithfont:(UIFont *)font textColor:(UIColor *)color Frame:(CGRect)frame Text:(NSString *)text {
    UILabel *label = [self creatWithText:text font:font textColor:color];
    label.frame = frame;
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}
@end
#pragma clang diagnostic pop
