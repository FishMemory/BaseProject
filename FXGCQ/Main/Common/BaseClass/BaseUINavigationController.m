//
//  BaseUINavigationController.m
//   
//
//  Created by Michael 
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUINavigationController.h"
@interface BaseUINavigationController()<UIGestureRecognizerDelegate>
@end

@implementation BaseUINavigationController

- (BOOL)shouldAutorotate {
    
    if([self.topViewController respondsToSelector:@selector(shouldAutorotate)]){
        return [self.topViewController shouldAutorotate];
    }
    return NO;
}
                                                                                                                        
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if([self.topViewController respondsToSelector:@selector(shouldAutorotateToInterfaceOrientation:)]){
        return [self.topViewController supportedInterfaceOrientations];
    }
    return [super supportedInterfaceOrientations];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if([self.topViewController respondsToSelector:@selector(preferredInterfaceOrientationForPresentation)]){
        return [self.topViewController preferredInterfaceOrientationForPresentation];
    }
    return [super preferredInterfaceOrientationForPresentation];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        [viewController setHidesBottomBarWhenPushed:YES]; 
    }
  [super pushViewController:viewController animated:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.interactivePopGestureRecognizer.delegate =  self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    return YES;
}
@end
