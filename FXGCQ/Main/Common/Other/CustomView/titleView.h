//
//  titleView.h
//  3dMagicCamera
//
//  Created by 宋亚清 on 15/4/9.
//  Copyright (c) 2015年 宋亚清. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface titleView : UILabel

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)titlestring titleColor:(UIColor *)titleColor position:(NSTextAlignment)textPosition;
@property(nonatomic,copy)NSString *labelText;
@property(nonatomic,copy)UIColor *color;
-(void)setLabelColor:(UIColor *)color;
@end
