//
//  StartView.m
//  WenXiaoYou
//
//  Created by lantuiOS on 16/2/24.
//  Copyright © 2016年 lantuiOS. All rights reserved.
//

#import "StartView.h"

@implementation StartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    [self setupView];
    }
    return self;
}

- (void)setupView{
    
    self.backgroundColor = [UIColor whiteColor];
    
//  scrollView
    
    self.startScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -kTopSafeHeight, SCREEN_WIDTH, SCREEN_HEIGHT + kTopSafeHeight)];
    
    self.startScroll.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_startScroll];
    
//  跳过按钮
    
    self.skip = [UIButton buttonWithType:UIButtonTypeSystem];

    self.skip.frame = CGRectMake(SCREEN_WIDTH - 80, 30, 60, 30);
    
//    self.skip.backgroundColor  = [UIColor colorWithWhite:0.565 alpha:0.473];
    
    [self.skip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.skip setTitle:@"跳过" forState:UIControlStateNormal];
    
    [self addSubview:_skip];
    self.skip.hidden = YES;
    
//  pageControl
    
    self.startPage = [[UIPageControl alloc]initWithFrame:CGRectMake(PX(230), SCREEN_HEIGHT - PX(154), PX(286), PX(94))];
    
    self.startPage.numberOfPages  = 3;
    
    self.startPage.backgroundColor = [UIColor clearColor];
    
    self.startPage.pageIndicatorTintColor = COL_GRAY_LINE;
    
    self.startPage.currentPageIndicatorTintColor = COL_THEME_BLUE;
    
//    [self addSubview:_startPage];
    
}




@end
