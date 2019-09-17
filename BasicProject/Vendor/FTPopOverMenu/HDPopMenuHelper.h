//
//  HDPodMenuHelper.h
//  Demo
//
//  Created by cool on 2018/8/2.
//  Copyright © 2018年 cool. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FTPopOverMenu.h"

@interface HDPopMenuHelper : NSObject

/// 首页下拉框
+ (void) showForSender:(UIView *)sender
         withMenuArray:(NSArray<NSString*> *)menuArray
            imageArray:(NSArray *)imageArray
             doneBlock:(FTPopOverMenuDoneBlock)doneBlock
          dismissBlock:(FTPopOverMenuDismissBlock)dismissBlock;

/// 合同模块下拉框
+ (void) showForSender:(UIView *)sender
         withMenuArray:(NSArray<NSString*> *)menuArray
             doneBlock:(FTPopOverMenuDoneBlock)doneBlock
          dismissBlock:(FTPopOverMenuDismissBlock)dismissBlock;

@end
