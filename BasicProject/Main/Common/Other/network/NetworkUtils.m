//
//  netWorkError.m
//  LifeCamera
//
//  Created by 宋亚清 on 15/6/25.
//
//

#import "NetworkUtils.h"
//#import "AppDelegate1.h"
#import "NetWorkDecideD.h"
@implementation NetworkUtils
+(BOOL)checkNetWork:(UIView *)alertView{
    if ([NetWorkDecideD IsEnableNonNetWork]){
        if (alertView){
        }else{
            alertView = [UIApplication sharedApplication].keyWindow;
        }
        [[ProgressHUD instance] showWarnProgressHD:YES inView:alertView info:@"无法连接到网络,请确认网络连接状态"];
        double delayInSeconds = 1.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [[ProgressHUD instance] showWarnProgressHD:NO inView:alertView info:@"无法连接到网络,请确认网络连接状态"];
        });
        
        return YES;
    }
    return NO;
}
@end
