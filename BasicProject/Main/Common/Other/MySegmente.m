//
//  MySegmente.m
//   
//
//  Created by 宋亚清 on 16/3/18.
//  Copyright © 2016年  . All rights reserved.
//

#import "MySegmente.h"

@implementation MySegmente
-(void)setSegmentedControlWhithNameArray:(NSArray *)nameArray view:(UIView *)view {
    _segmentNameArray = [[NSArray alloc]initWithObjects:@"热门",@"新鲜",@"同城",nil];
    //初始化UISegmentedControl
    self.mySegment = [[UISegmentedControl alloc]initWithItems:_segmentNameArray];
    self.mySegment.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    //设置默认选择项索引
    [_mySegment setSelectedSegmentIndex:0];
//    _differentStr = @"未支付";
    _mySegment.backgroundColor = [UIColor whiteColor];
    _mySegment.tintColor = [UIColor whiteColor];//去掉颜色,现在整个segment都看不见
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                             NSForegroundColorAttributeName: [UIColor blackColor]};
    [_mySegment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                               NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:1]};
    
    [_mySegment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _mySegment.bottom, SCREEN_WIDTH/3, 1.00f)];
    _lineView.backgroundColor = RGB(255, 0 , 0);
    _lineView.center =  CGPointMake(SCREEN_WIDTH/_segmentNameArray.count/2.0, _mySegment.bottom-1);
    [_mySegment addSubview:_lineView];
    //设置样式
    [self.mySegment addTarget:self action:@selector(segmentActiono:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    [view addSubview:_mySegment];

}

-(void)segmentActiono:(id)sender{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    NSLog(@"%@--------",@(segment.selectedSegmentIndex));
    _lineView.center =  CGPointMake(SCREEN_WIDTH/(_segmentNameArray.count*2.0) + SCREEN_WIDTH/_segmentNameArray.count*segment.selectedSegmentIndex, _mySegment.bottom-1);
    
    if (self.segmentedAction) {
        self.segmentedAction((id) sender);
    }
}
-(void)setLineView:(UIView *)lineView{
    self.lineView = lineView;
}
-(void)setLineColor:(UIColor *)lineColor{
    self.lineView.backgroundColor = lineColor;
}
@end
