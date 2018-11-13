//
//  ProgressHUD.m
//
//  Created by 宋亚清 on 15/4/14.
//  Copyright (c) 2015年 宋亚清. All rights reserved.
//

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define UI_ASYNC_TASK(block)  dispatch_async(dispatch_get_main_queue(), (block));

#import "ProgressHUD.h"

@implementation ProgressHUD

@synthesize hud = _hud;
- (void)showProgressHD:(BOOL)tf inView:(UIView *)inView info:(NSString *)info
{
    // 保证在主线程中执行
    dispatch_async(dispatch_get_main_queue(), ^{
        if(inView == nil && !(inView.frame.size.width > 0)){
            return;
        }
        if (tf == YES) {
            if (self.hud == nil) {
                self.hud = [[MBProgressHUD alloc] initWithView:inView];
                //hud.mode = MBProgressHUDModeCustomView;
                self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
                self.hud.yOffset = self->offsetY;
                [inView addSubview:self.hud];
            }
            self.hud.mode = MBProgressHUDModeCustomView;
            self.hud.labelText = info;
            [self.hud show:YES];
            //[hud hide:YES afterDelay:0.5];
        } else {
            if (self.hud != nil) {
                [self.hud hide:YES];
                [self.hud removeFromSuperview];
                self.hud = nil;
            }
        }
    });
}
#pragma mark <--对号 完成提示图片- ->
- (void)completedProgressHDView:(UIView *)inView time:(NSTimeInterval)time info:(NSString *)info{
    // 保证在主线程中执行
    dispatch_async(dispatch_get_main_queue(), ^{
        if(inView == nil && !(inView.frame.size.width > 0)){
            return;
        }
        if (self.hud == nil) {
            self.hud = [[MBProgressHUD alloc] initWithView:inView];
            self.hud.mode = MBProgressHUDModeCustomView;
            self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"answer_sure_icon"]];
            self.hud.yOffset = -80;
            [inView addSubview:self.hud];
        }
        
        //        if (info.length > 15) {
        //            self.hud.detailsLabelText = info;
        //        }else{
        //            self.hud.labelText = info;
        //        }
        self.hud.detailsLabelText = info;
        
        [self.hud show:YES];
        [self.hud hide:YES afterDelay:time];
        double delayInSeconds = time;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (self.hud != nil){
                [self.hud removeFromSuperview];
                self.hud = nil;
            }
        });
    });
}

#pragma mark <--失败 提示图片- ->
- (void)showFailProgressHD:(UIView *)inView time:(NSTimeInterval)time info:(NSString *)info{
    // 保证在主线程中执行
    dispatch_async(dispatch_get_main_queue(), ^{
        if(inView == nil && !(inView.frame.size.width > 0)){
            return;
        }
        if (self.hud == nil) {
            self.hud = [[MBProgressHUD alloc] initWithView:inView];
            self.hud.mode = MBProgressHUDModeCustomView;
            self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fault"]];
            self.hud.yOffset = -80;
            [inView addSubview:self.hud];
        }
        
        //        if (info.length > 15) {
        //            self.hud.detailsLabelText = info;
        //        }else{
        //            self.hud.labelText = info;
        //        }
        self.hud.detailsLabelText = info;
        
        [self.hud show:YES];
        [self.hud hide:YES afterDelay:time];
        double delayInSeconds = time;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (self.hud != nil){
                [self.hud removeFromSuperview];
                self.hud = nil;
            }
        });
    });
}
#pragma mark <--失败 提示图片- 输入弹框位置 ->
- (void)showFailProgressHD:(UIView *)inView time:(NSTimeInterval)time info:(NSString *)info topX:(NSInteger)topX
{
    // 保证在主线程中执行
    dispatch_async(dispatch_get_main_queue(), ^{
        if(inView == nil && !(inView.frame.size.width > 0)){
            return;
        }
        if (self.hud == nil) {
            self.hud = [[MBProgressHUD alloc] initWithView:inView];
            self.hud.mode = MBProgressHUDModeCustomView;
            self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fault"]];
            self.hud.yOffset = -topX;
            [inView addSubview:self.hud];
        }
        
        //        if (info.length > 15) {
        //            self.hud.detailsLabelText = info;
        //        }else{
        //            self.hud.labelText = info;
        //        }
        self.hud.detailsLabelText = info;
        
        [self.hud show:YES];
        [self.hud hide:YES afterDelay:time];
        double delayInSeconds = time;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (self.hud != nil){
                [self.hud removeFromSuperview];
                self.hud = nil;
            }
        });
    });
}

#pragma mark <--叹号提示图片- 需手动移除->
- (void)showWarnProgressHD:(BOOL)tf inView:(UIView *)inView info:(NSString *)info
{
    
    // 保证在主线程中执行
    dispatch_async(dispatch_get_main_queue(), ^{
        if(inView == nil && !(inView.frame.size.width > 0)){
            return;
        }
        if (tf == YES) {
            if (self.hud == nil) {
                self.hud = [[MBProgressHUD alloc] initWithView:inView];
                self.hud.mode = MBProgressHUDModeCustomView;
                self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
                self.hud.yOffset = self->offsetY;
                [inView addSubview:self.hud];
            }
            
            self.hud.mode = MBProgressHUDModeCustomView;
            self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_tips_dialog"]];
            self.hud.yOffset = self->offsetY;
            [inView addSubview:self.hud];
            
            if (info.length > 15) {
                self.hud.detailsLabelText = info;
            }else{
                self.hud.labelText = info;
            }
            [self.hud show:YES];
            //[self.hud hide:YES afterDelay:0.5];
        } else {
            if (self.hud != nil) {
                [self.hud hide:YES];
                [self.hud removeFromSuperview];
                self.hud = nil;
            }
        }
    });
}
#pragma mark <-- 无图带定时的 提示,延时time后，自动消失-->
- (void)showWarnHUDWithTimer:(UIView *)inView time:(NSTimeInterval) time info:(NSString *)info
{
    // 保证在主线程中执行
    dispatch_async(dispatch_get_main_queue(), ^{
        if(inView == nil && !(inView.frame.size.width > 0)){
            return;
        }
        if (self.hud == nil) {
            self.hud = [[MBProgressHUD alloc] initWithView:inView];
            self.hud.mode = MBProgressHUDModeCustomView;
            //            self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_tips_dialog"]];
            self.hud.yOffset = self->offsetY;
            [inView addSubview:self.hud];
        }
        
        if (info.length > 15) {
            self.hud.detailsLabelText = info;
        }else{
            self.hud.labelText = info;
        }
        [self.hud show:YES];
        [self.hud hide:YES afterDelay:time];
        double delayInSeconds = time;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (self.hud != nil){
                [self.hud removeFromSuperview];
                self.hud = nil;
            }
        });
    });
}
#pragma mark <--带定时的叹号提示图片,延时time后，自动消失-->
- (void)showWarnProgressHDWithTimer:(UIView *)inView time:(NSTimeInterval) time info:(NSString *)info
{
    // 保证在主线程中执行
    dispatch_async(dispatch_get_main_queue(), ^{
        if(inView == nil && !(inView.frame.size.width > 0)){
            return;
        }
        
        if (self.hud == nil) {
            self.hud = [[MBProgressHUD alloc] initWithView:inView];
            self.hud.mode = MBProgressHUDModeCustomView;
            self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_tips_dialog"]];
            self.hud.yOffset = -80;
            [inView addSubview:self.hud];
        }
        
        if (info.length > 15) {
            self.hud.detailsLabelText = info;
        }else{
            self.hud.labelText = info;
        }
        
        
        [self.hud show:YES];
        [self.hud hide:YES afterDelay:time];
        double delayInSeconds = time;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (self.hud != nil){
                [self.hud removeFromSuperview];
                self.hud = nil;
            }
        });
    });
}

+ (id)instance
{
    static ProgressHUD *ph;
    if (ph == nil) {
        ph = [[ProgressHUD alloc] init];
    }
    return ph;
}

- (void)setOffsetY:(CGFloat)y
{
    offsetY = y;
}

-(void)setModel:(MBProgressHUDMode)model{
    self.hud.mode = model;
}

-(void)setMessage:(NSString*)title detail:(NSString*)detail{
    self.hud.labelText = title;
    self.hud.detailsLabelText = detail;
}

//  loading  等待。。。。
- (void)showBackProgressHD:(BOOL)tf inView:(UIView *)inView info:(NSString *)info
{
    if(inView == nil && !(inView.frame.size.width > 0)){
        return;
    }
    // 保证在主线程中执行
    UI_ASYNC_TASK(^{
        if (tf == YES) {
            if (self.hud == nil) {
                self.hud = [[MBProgressHUD alloc] initWithView:inView];
                [inView addSubview:self.hud];
                //                self.hud.backgroundColor = [UIColor clearColor];
            }
            //            self.hud.dimBackground = YES;
            self.hud.labelText = info;
            //             self.hud.backgroundColor = [UIColor clearColor];
            //            self.hud.customView.backgroundColor = [UIColor redColor];
            self.hud.color = rgba(0, 0, 0, 0.5f);
            [self.hud show:YES];
            
        } else {
            if (self.hud != nil) {
                [self.hud hide:YES];
                [self.hud removeFromSuperview];
                self.hud = nil;
            }
        }
    });
}


//只显示文字
- (void)showOnlyTextProgressHDWithTimer:(NSTimeInterval)time inView:(UIView *)inView info:(NSString *)info
{
    // 保证在主线程中执行
    UI_ASYNC_TASK(^{
        if(inView == nil && !(inView.frame.size.width > 0)){
            return;
        }
        
        if (self.hud == nil) {
            self.hud = [[MBProgressHUD alloc] initWithView:inView];
            self.hud.margin = 10.f;
            //            self.hud.dimBackground = YES;
            [inView addSubview:self.hud];
        }
        self.hud.color = rgba(0, 0, 0, 0.5f);
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = info;
        [self.hud show:YES];
        [self.hud hide:YES afterDelay:time];
        
    });
    
}

- (void)showOnlyBarProgressHD:(BOOL)tf inView:(UIView *)inView info:(NSString *)info
{
    // 保证在主线程中执行
    UI_ASYNC_TASK(^{
        if(inView == nil && !(inView.frame.size.width > 0)){
            return;
        }
        
        if (tf == YES) {
            if (self.hud1 == nil) {
                self.hud1 = [[MBProgressHUD alloc] initWithView:inView];
                
                // hud.labelText = info;
                self.hud1.margin = 10.f;
                
                //hud.removeFromSuperViewOnHide = YES;
                //hud.dimBackground = YES;
                //  [hud hide:YES afterDelay:3];
                
                [inView addSubview:self.hud1];
            }
            self.hud1.mode = MBProgressHUDModeDeterminateHorizontalBar;
            self.hud1.labelText = info;
            self.hud1.color = rgba(0, 0, 0, 0.5f);
            [self.hud1 show:YES];
            // [hud hide:YES afterDelay:1.5];
        } else {
            if (self.hud1 != nil) {
                [self.hud1 hide:YES];
                [self.hud1 removeFromSuperview];
                self.hud1 = nil;
            }
        }
    });
}
-(void)setProgress:(CGFloat)progress{
    if (self.hud1){
        self.hud1.progress = progress;
    }
}
-(void)imageViewShowback:(BOOL)show inView:(UIView *) inView
{
    if (inView == nil && !(inView.frame.size.width > 0) ) {
        return;
    }
    if (show == YES) {
        self.hud1 = [[MBProgressHUD alloc]initWithView:inView];
        self.hud1.color = [UIColor clearColor];
        [self.hud1 show:YES];
    }else{
        [self.hud1 hide:YES];
        [self.hud1 removeFromSuperview];
    }
    
    
}
@end

