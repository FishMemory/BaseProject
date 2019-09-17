//
//  MyPageControl.m
//   
//
//  Created by 宋亚清 on 16/11/14.
//  Copyright © 2016年  . All rights reserved.
//

#import "MyPageControl.h"

@implementation MyPageControl
-(instancetype)initWithFrame:(CGRect)frame{
    self =  [super initWithFrame:frame];
    if (self) {
        self.indicatorDiameter = PX(34);
        self.indicatorMargin = PX(10);
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)page{
    [super setCurrentPage: page];

}

-(void) updateDots

{
    for (int i=0; i<[self.subviews count]; i++) {
        
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        CGSize size;
        
        size.height = 7;     //自定义圆点的大小
        size.width = 7;      //自定义圆点的大小
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width, size.width)];
        if (i==self.currentPage)dot.image=[UIImage imageWithColor:COL_THEME size:CGSizeMake(8, 8)];
        
        else dot.image=[UIImage imageWithColor:COL_GRAY_LINE size:CGSizeMake(8, 8)];
    }
    
}
@end
