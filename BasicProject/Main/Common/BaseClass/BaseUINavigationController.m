//
//  BaseUINavigationController.m
//   
//
//  Created by Michael 
//  Copyright © 2016年  . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUINavigationController.h"


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
@end
