//
//  MySegmente.h
//   
//
//  Created by 宋亚清 on 16/3/18.
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySegmente : NSObject
@property (strong, nonatomic) UISegmentedControl *mySegment;
@property (strong, nonatomic) UIView *lineView; /**< 标记线 >*/
@property (strong, nonatomic) NSArray *segmentNameArray; /**< 名称数组 >*/
@property (copy, nonatomic) void (^segmentedAction) (UIButton *button);
@property (strong, nonatomic) UIColor *lineColor; /**< 线颜色 >*/
-(void)setSegmentedControlWhithNameArray:(NSArray *)nameArray view:(UIView *)view;
@end
