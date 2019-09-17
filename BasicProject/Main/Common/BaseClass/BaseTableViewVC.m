//
//  BaseTableViewVC.m
//  FXGCQ
//
//  Created by 宋亚清 on 2019/9/3.
//  Copyright © 2019 ZLWL. All rights reserved.
//

#import "BaseTableViewVC.h"

@interface BaseTableViewVC ()

@end

@implementation BaseTableViewVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:YES];;
}

-(void)backAct{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.设置title文字颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    UIImage * naviBkgImg = [UIImage imageWithColor:COL_THEME size:CGSizeMake(SCREEN_WIDTH,kTopSafeHeight)];
    [self.navigationController.navigationBar setBackgroundImage:naviBkgImg forBarMetrics:UIBarMetricsDefault];
    
    // 3.毛玻璃
    self.navigationController.navigationBar.translucent = NO;
    // 4.隐藏横线
    UIImageView *navImageView = [self findlineviw:self.navigationController.navigationBar];
    navImageView.hidden = YES;
    self.navigationItem.leftBarButtonItem =  [UIBarButtonItem barButtonItemWithImage:@"back_icon" andBarButtonItemBlock:^{
        [self backAct];
    }];
   
}


-(UIImageView*)findlineviw:(UIView*)view{
    if ([view isKindOfClass:[UIImageView class]]&&view.bounds.size.height<=1.0) {
        return (UIImageView*) view;
    }for (UIImageView *subview in view.subviews) {
        UIImageView *lineview = [self findlineviw:subview];
        if (lineview) {
            return lineview;
        }
    }
    return nil;
}
@end
