//
//  HDPodMenuHelper.m
//  Demo
//
//  Created by cool on 2018/8/2.
//  Copyright © 2018年 liufengting. All rights reserved.
//

#import "HDPopMenuHelper.h"

@implementation HDPopMenuHelper

+ (void)showForSender:(UIView *)sender withMenuArray:(NSArray<NSString *> *)menuArray imageArray:(NSArray *)imageArray doneBlock:(FTPopOverMenuDoneBlock)doneBlock dismissBlock:(FTPopOverMenuDismissBlock)dismissBlock{
    
    // 1. 进行弹窗相关配置
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    // 行高
    configuration.menuRowHeight = 40;
    // pop 宽度
    configuration.menuWidth = 120;
    // 字体颜色
    configuration.textColor = [UIColor blackColor];
    // 字体大小
    configuration.textFont = [UIFont systemFontOfSize:14];
    configuration.textAlignment = NSTextAlignmentLeft;
    // 箭头颜色相关
    configuration.borderColor = [UIColor whiteColor];
    configuration.tintColor = [UIColor whiteColor];

    // tableView背景色
    configuration.tableViewBackgroundColor = [UIColor whiteColor];
    
    // 背景色
    configuration.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:.7f];

    // 2. 弹窗逻辑处理
    [FTPopOverMenu showForSender:sender withMenuArray:menuArray imageArray:imageArray doneBlock:^(NSInteger selectedIndex) {
        if (doneBlock) {
            doneBlock(selectedIndex);
        }
    } dismissBlock:^{
        if (dismissBlock) {
            dismissBlock();
        }
    }];
}
+ (void)showForSender:(UIView *)sender withMenuArray:(NSArray<NSString *> *)menuArray doneBlock:(FTPopOverMenuDoneBlock)doneBlock dismissBlock:(FTPopOverMenuDismissBlock)dismissBlock{
    
    // 1. 进行弹窗相关配置
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.menuRowHeight = 40;
    configuration.menuWidth = 80;
    configuration.textColor = [UIColor whiteColor];
    configuration.textFont = [UIFont systemFontOfSize:14];
    configuration.textAlignment = NSTextAlignmentCenter;
    
    // 箭头颜色相关
    configuration.borderColor = [UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:.9f];
    configuration.tintColor = [UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:.9f];
    
    // tableView背景色
    configuration.tableViewBackgroundColor = [UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:.7f];
    
    // 背景色
    configuration.backgroundColor = [UIColor clearColor];
    
    // 2. 弹窗逻辑处理
    [FTPopOverMenu showForSender:sender withMenuArray:menuArray doneBlock:^(NSInteger selectedIndex) {
        if (doneBlock) {
            doneBlock(selectedIndex);
        }
    } dismissBlock:^{
        if (dismissBlock) {
            dismissBlock();
        }
    }];
}
@end
