//
//  DeleLine.m
//   
//
//  Created by   on 16/3/16.
//  Copyright © 2016年  . All rights reserved.
//

#import "DeleLine.h"

@implementation DeleLine
+ (instancetype)deleteNavigateLine:(UINavigationController *)navigationController{
    if ([navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list = navigationController.navigationBar.subviews;
        for (id obj in list) {
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
            {//10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]])
                    {
                        
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = YES;
                    }
                }
            }else{
                if ([obj isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    for (id obj2 in list2) {
                        if ([obj2 isKindOfClass:[UIImageView class]]) {
                            
                            UIImageView *imageView2=(UIImageView *)obj2;
                            imageView2.hidden=YES;
                        }
                    }
                }
            }
        }
    }
    return nil;
}
+ (instancetype)addNavigateLine:(UINavigationController *)navigationController{
    if ([navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list = navigationController.navigationBar.subviews;
        for (id obj in list) {
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
            {//10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]])
                    {
                        
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = NO;
                    }
                }
            }else{
                if ([obj isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    for (id obj2 in list2) {
                        if ([obj2 isKindOfClass:[UIImageView class]]) {
                            
                            UIImageView *imageView2=(UIImageView *)obj2;
                            imageView2.hidden= NO;
                        }
                    }
                }
            }
        }
    }
    return nil;
}
@end
