//
//  AppDelegate.m
//
//  Created by 宋亚清 on 2018/11/13.
//  Copyright © 2018 ZLWL. All rights reserved.
//

#import "TabBarControllerViewController.h"
//#import "StartViewController.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#pragma mark- 键盘自动回收
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    manager.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [DefaultCenter addObserver:self selector:@selector(MianVC) name:@"mian" object:nil];
    [DefaultCenter addObserver:self selector:@selector(loginVC) name:@"login" object:nil];
    
    if (APP.curUserId) {
        [self MianVC];
    }else{
        [self loginVC];
    }

    return YES;
}
-(void)MianVC{
    TabBarControllerViewController * tabBarVc =  [[TabBarControllerViewController alloc]init];
    [DeleLine deleteNavigateLine:tabBarVc.navigationController];
    self.window.rootViewController  = tabBarVc;
    tabBarVc.selectedIndex = 0;
}
-(void)loginVC{
//    LoginVC *vc = [LoginVC new];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    self.window.rootViewController  = nav;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  
}

- (void)applicationWillTerminate:(UIApplication *)application {
  
}


@end
